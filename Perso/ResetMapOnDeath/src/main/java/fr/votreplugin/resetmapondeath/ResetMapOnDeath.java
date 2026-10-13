package fr.votreplugin.resetmapondeath;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import net.md_5.bungee.api.ChatMessageType;
import net.md_5.bungee.api.chat.TextComponent;
import org.bukkit.Bukkit;
import org.bukkit.EntityEffect;
import org.bukkit.GameMode;
import org.bukkit.Location;
import org.bukkit.NamespacedKey;
import org.bukkit.Sound;
import org.bukkit.World;
import org.bukkit.WorldCreator;
import org.bukkit.advancement.Advancement;
import org.bukkit.advancement.AdvancementProgress;
import org.bukkit.boss.BarColor;
import org.bukkit.boss.BarStyle;
import org.bukkit.boss.BossBar;
import org.bukkit.command.Command;
import org.bukkit.command.CommandSender;
import org.bukkit.entity.EntityType;
import org.bukkit.entity.LivingEntity;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.EntityDamageEvent;
import org.bukkit.event.entity.EntityDeathEvent;
import org.bukkit.event.entity.PlayerDeathEvent;
import org.bukkit.event.player.PlayerJoinEvent;
import org.bukkit.event.player.PlayerPortalEvent;
import org.bukkit.event.player.PlayerRespawnEvent;
import org.bukkit.event.player.PlayerTeleportEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.plugin.java.JavaPlugin;
import org.bukkit.potion.PotionEffect;
import org.bukkit.potion.PotionEffectType;
import org.bukkit.scoreboard.DisplaySlot;
import org.bukkit.scoreboard.Objective;
import org.bukkit.scoreboard.RenderType;
import org.bukkit.scoreboard.Scoreboard;
import org.bukkit.scoreboard.ScoreboardManager;

/**
 * Main class handling the chaotic hardcore game mode.
 * Features include global damage sharing, automatic world resets, random potion effects,
 * and periodic inventory swapping among players.
 */
public class ResetMapOnDeath extends JavaPlugin implements Listener {

  private boolean resetting = false;
  private boolean sharingDamage = false;

  private static final String WORLD_NAME = "game";
  private static final String NETHER_NAME = "game_nether";
  private static final String END_NAME = "game_the_end";

  private final Map<UUID, Integer> playerDeaths = new HashMap<>();

  private Scoreboard scoreboard;
  private Objective deathsObjective;
  private Objective healthBelowName;
  private Objective healthPlayerList;

  private BossBar activePotionBossBar;
  private int bossBarTaskId = -1;

  private int currentRunTime = 0;
  private int runCount = 1;
  private double totalRunDamage = 0.0;

  private int timerTaskId = -1;
  private int randomPotionTaskId = -1;
  private int autoSaveTaskId = -1;
  private int swapInventoryTaskId = -1;

  private Player culpritPlayer = null;

  @Override
  public void onEnable() {
    getServer().getPluginManager().registerEvents(this, this);
    getLogger().info("Plugin ResetMapOnDeath activated - Mode Hardcore Chaos Persistant");

    setupScoreboard();
    loadPlayerData();

    // Disables spawn protection to allow immediate block breaking.
    Bukkit.setSpawnRadius(0);

    if (Bukkit.getWorld(WORLD_NAME) == null) {
      getLogger().info("Creating initial game worlds...");
      createGameWorlds();
    }

    startTimers();
  }

  @Override
  public void onDisable() {
    if (activePotionBossBar != null) {
      activePotionBossBar.removeAll();
    }
    savePlayerData();
    stopTimers();
    getLogger().info("Plugin deactivated - Data saved.");
  }

  /**
   * Sets up the scoreboard and its health/death objectives.
   */
  private void setupScoreboard() {
    ScoreboardManager manager = Bukkit.getScoreboardManager();
    scoreboard = manager.getNewScoreboard();

    deathsObjective = scoreboard.registerNewObjective("deaths", "dummy", "§4§lMORTS ✝");
    deathsObjective.setDisplaySlot(DisplaySlot.SIDEBAR);

    healthBelowName = scoreboard.registerNewObjective("h_name", "health", "§c❤");
    healthBelowName.setDisplaySlot(DisplaySlot.BELOW_NAME);
    healthBelowName.setRenderType(RenderType.HEARTS);

    healthPlayerList = scoreboard.registerNewObjective("h_tab", "health", "§c❤");
    healthPlayerList.setDisplaySlot(DisplaySlot.PLAYER_LIST);
    healthPlayerList.setRenderType(RenderType.HEARTS);
  }

  /**
   * Updates the death count on the scoreboard for a specific player.
   *
   * @param player The target player.
   * @param deaths The new death count.
   */
  private void updateScoreboard(Player player, int deaths) {
    if (deathsObjective != null) {
      deathsObjective.getScore(player.getName()).setScore(deaths);
    }
  }

  /**
   * Starts all necessary scheduled tasks for the game loop.
   */
  private void startTimers() {
    stopTimers();

    timerTaskId = Bukkit.getScheduler().scheduleSyncRepeatingTask(this, () -> {
      currentRunTime++;
      String timeString = formatTime(currentRunTime);

      for (Player p : Bukkit.getOnlinePlayers()) {
        p.setPlayerListHeader("§c§lOn va choquer KZ");
        p.setPlayerListFooter(
            "§eTemps: §f" + timeString + " §7| §6Tentative N°: §f" + runCount);
      }
    }, 0L, 20L);

    randomPotionTaskId = Bukkit.getScheduler()
        .scheduleSyncRepeatingTask(this, this::applyRandomEffect, 600L, 600L);

    autoSaveTaskId = Bukkit.getScheduler().scheduleSyncRepeatingTask(this, () -> {
      savePlayerData();
      getLogger().info("Automatic data save completed.");
    }, 6000L, 6000L);

    swapInventoryTaskId = Bukkit.getScheduler()
        .scheduleSyncRepeatingTask(this, this::swapPlayerInventories, 6000L, 6000L);
  }

  /**
   * Stops all active scheduled tasks.
   */
  private void stopTimers() {
    if (timerTaskId != -1) Bukkit.getScheduler().cancelTask(timerTaskId);
    if (randomPotionTaskId != -1) Bukkit.getScheduler().cancelTask(randomPotionTaskId);
    if (autoSaveTaskId != -1) Bukkit.getScheduler().cancelTask(autoSaveTaskId);
    if (bossBarTaskId != -1) Bukkit.getScheduler().cancelTask(bossBarTaskId);
    if (swapInventoryTaskId != -1) Bukkit.getScheduler().cancelTask(swapInventoryTaskId);
  }

  /**
   * Shuffles the personal inventories of all online survival players in a cyclic pattern.
   */
  private void swapPlayerInventories() {
    if (resetting) {
      return;
    }

    List<Player> players = new ArrayList<>();
    for (Player p : Bukkit.getOnlinePlayers()) {
      if (p.getGameMode() == GameMode.SURVIVAL) {
        players.add(p);
      }
    }

    if (players.size() > 1) {
      Collections.shuffle(players);

      Player firstPlayer = players.get(0);
      ItemStack[] firstContents = firstPlayer.getInventory().getContents();
      ItemStack[] firstArmor = firstPlayer.getInventory().getArmorContents();
      ItemStack[] firstExtra = firstPlayer.getInventory().getExtraContents();

      for (int i = 0; i < players.size() - 1; i++) {
        Player current = players.get(i);
        Player next = players.get(i + 1);

        current.getInventory().setContents(next.getInventory().getContents());
        current.getInventory().setArmorContents(next.getInventory().getArmorContents());
        current.getInventory().setExtraContents(next.getInventory().getExtraContents());
      }

      Player lastPlayer = players.get(players.size() - 1);
      lastPlayer.getInventory().setContents(firstContents);
      lastPlayer.getInventory().setArmorContents(firstArmor);
      lastPlayer.getInventory().setExtraContents(firstExtra);

      Bukkit.broadcastMessage("§d§l[!] Les inventaires personnels viennent d'etre echanges !");
      for (Player p : players) {
        p.playSound(p.getLocation(), Sound.ENTITY_ENDERMAN_TELEPORT, 1f, 1f);
      }
    }
  }

  /**
   * Applies two random potion effects to all players.
   */
  private void applyRandomEffect() {
    if (resetting) {
      return;
    }

    List<PotionEffectType> allEffects = new ArrayList<>();
    for (PotionEffectType type : PotionEffectType.values()) {
      if (type != null && !type.getName().contains("HARM")) {
        allEffects.add(type);
      }
    }

    if (allEffects.isEmpty()) {
      return;
    }

    Random random = new Random();
    PotionEffectType type1 = allEffects.get(random.nextInt(allEffects.size()));
    PotionEffectType type2 = allEffects.get(random.nextInt(allEffects.size()));

    int durationTicks = 200;
    boolean sameEffect = type1.equals(type2);
    int amp1 = sameEffect ? 1 : 0;
    int amp2 = 0;

    if (type1.getName().contains("POISON")) amp1 = 0;
    if (type2.getName().contains("POISON")) amp2 = 0;

    PotionEffect effect1 = new PotionEffect(type1, durationTicks, amp1);
    PotionEffect effect2 = new PotionEffect(type2, durationTicks, amp2);

    if (type1.getName().contains("GLOWING") || type2.getName().contains("GLOWING")) {
      for (World w : Bukkit.getWorlds()) {
        for (LivingEntity entity : w.getLivingEntities()) {
          if (!(entity instanceof Player)) {
            entity.addPotionEffect(new PotionEffect(PotionEffectType.GLOWING, durationTicks, 0));
          }
        }
      }
    }

    if (activePotionBossBar != null) {
      activePotionBossBar.removeAll();
      if (bossBarTaskId != -1) Bukkit.getScheduler().cancelTask(bossBarTaskId);
    }

    String name1 = type1.getName().toLowerCase().replace("_", " ").toUpperCase();
    name1 = name1.contains(":") ? name1.split(":")[1] : name1;

    String name2 = type2.getName().toLowerCase().replace("_", " ").toUpperCase();
    name2 = name2.contains(":") ? name2.split(":")[1] : name2;

    String bossBarTitle = sameEffect ? name1 + " II" : name1 + " & " + name2;
    BarColor color = BarColor.BLUE;

    activePotionBossBar = Bukkit.createBossBar("§b§lEFFETS: §f" + bossBarTitle, color, BarStyle.SOLID);
    activePotionBossBar.setProgress(1.0);

    for (Player p : Bukkit.getOnlinePlayers()) {
      if (p.getGameMode() == GameMode.SURVIVAL) {
        p.addPotionEffect(effect1);
        if (!sameEffect) {
          p.addPotionEffect(effect2);
        }
        p.playSound(p.getLocation(), Sound.BLOCK_BREWING_STAND_BREW, 1f, 1f);
        activePotionBossBar.addPlayer(p);
      }
    }

    final double decrement = 1.0 / (durationTicks / 2.0);

    bossBarTaskId = Bukkit.getScheduler().scheduleSyncRepeatingTask(this, new Runnable() {
      double progress = 1.0;

      @Override
      public void run() {
        progress -= decrement;
        if (progress <= 0) {
          activePotionBossBar.removeAll();
          activePotionBossBar = null;
          Bukkit.getScheduler().cancelTask(bossBarTaskId);
          bossBarTaskId = -1;
        } else {
          activePotionBossBar.setProgress(progress);
        }
      }
    }, 0L, 2L);
  }

  /**
   * Handles damage distribution among all players and tracks total run damage.
   *
   * @param event The triggered entity damage event.
   */
  @EventHandler(priority = EventPriority.HIGHEST, ignoreCancelled = true)
  public void onPlayerDamage(EntityDamageEvent event) {
    if (sharingDamage || resetting) {
      return;
    }
    if (!(event.getEntity() instanceof Player)) {
      return;
    }

    Player victim = (Player) event.getEntity();
    double damage = event.getFinalDamage();

    if (damage <= 0) {
      return;
    }
    
    totalRunDamage += damage;

    if (victim.getHealth() - damage <= 0) {
      return;
    }

    sharingDamage = true;
    try {
      culpritPlayer = victim;
      String damageIcon = "§c☠ §l" + victim.getName() + " §ca pris des degats ! §4-"
          + String.format("%.1f", damage) + " PV";

      for (Player p : Bukkit.getOnlinePlayers()) {
        p.spigot().sendMessage(ChatMessageType.ACTION_BAR, TextComponent.fromLegacyText(damageIcon));

        if (!p.getUniqueId().equals(victim.getUniqueId()) && p.getGameMode() == GameMode.SURVIVAL) {
          if (p.getNoDamageTicks() > 10) continue;

          double newHealth = p.getHealth() - damage;
          if (newHealth < 0) newHealth = 0;

          p.setHealth(newHealth);
          p.playEffect(EntityEffect.HURT);
          p.setNoDamageTicks(victim.getMaximumNoDamageTicks());
        }
      }
    } finally {
      sharingDamage = false;
      Bukkit.getScheduler().runTask(this, () -> culpritPlayer = null);
    }
  }

  /**
   * Broadcasts the victory message when the Ender Dragon is defeated.
   *
   * @param event The entity death event.
   */
  @EventHandler
  public void onEntityDeath(EntityDeathEvent event) {
    if (event.getEntityType() == EntityType.ENDER_DRAGON) {
      if (event.getEntity().getWorld().getName().equals(END_NAME)) {
        Bukkit.broadcastMessage("§6§l▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬");
        Bukkit.broadcastMessage("§e§k|||§r §d§lVICTOIRE !|||");
        Bukkit.broadcastMessage("");
        Bukkit.broadcastMessage("§a§lRun terminee, GG les nullards !");
        Bukkit.broadcastMessage("§7Temps final: §f" + formatTime(currentRunTime));
        Bukkit.broadcastMessage("§7Degats totaux subis: §f" + String.format("%.1f", totalRunDamage));
        Bukkit.broadcastMessage("§6§l▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬");

        for (Player p : Bukkit.getOnlinePlayers()) {
          p.playSound(p.getLocation(), Sound.UI_TOAST_CHALLENGE_COMPLETE, 1.0f, 1.0f);
        }
      }
    }
  }

  /**
   * Triggers the game reset sequence and identifies the player who ruined the run.
   *
   * @param event The player death event.
   */
  @EventHandler
  public void onPlayerDeath(PlayerDeathEvent event) {
    if (resetting) {
      return;
    }
    resetting = true;

    Player dead = event.getEntity();
    incrementPlayerDeath(dead);

    runCount++;
    savePlayerData();

    Player ruiner = (culpritPlayer != null) ? culpritPlayer : dead;

    String deathMsg = getConfig().getString("message", "§c%player% est mort !")
        .replace("%player%", dead.getName());
    event.setDeathMessage(deathMsg);

    Bukkit.broadcastMessage("§4§l=================================");
    Bukkit.broadcastMessage("§c          GAME OVER");
    Bukkit.broadcastMessage("§e  Le coupable : " + ruiner.getName());
    Bukkit.broadcastMessage("§e  Temps vecu : " + formatTime(currentRunTime));
    Bukkit.broadcastMessage("§e  Degats subis dans la run : " + String.format("%.1f", totalRunDamage) + " PV");
    Bukkit.broadcastMessage("§4§l=================================");

    for (Player p : Bukkit.getOnlinePlayers()) {
      p.setGameMode(GameMode.SPECTATOR);
      p.sendTitle("§4§lECHEC", "§c" + ruiner.getName() + " a ruine la run", 10, 100, 20);

      if (activePotionBossBar != null) {
        activePotionBossBar.removePlayer(p);
      }
    }

    // Forces the dead player to respawn automatically to prevent world unmount locks.
    Bukkit.getScheduler().runTask(this, () -> {
      dead.spigot().respawn();
    });

    int delay = getConfig().getInt("reset-delay", 100);
    Bukkit.getScheduler().runTaskLater(this, this::resetGameWorlds, delay);
  }

  /**
   * Ensures players always respawn in the correct active world safely.
   *
   * @param event The player respawn event.
   */
  @EventHandler
  public void onPlayerRespawn(PlayerRespawnEvent event) {
    if (resetting) {
      World lobby = Bukkit.getWorlds().get(0);
      event.setRespawnLocation(lobby.getSpawnLocation());
    } else {
      World game = Bukkit.getWorld(WORLD_NAME);
      if (game != null) {
        event.setRespawnLocation(game.getSpawnLocation());
      }
    }
  }

  /**
   * Initiates the world deletion and recreation process safely.
   */
  private void resetGameWorlds() {
    Bukkit.broadcastMessage("§e♻ Generation d'une nouvelle map...");

    World lobby = Bukkit.getWorlds().get(0);
    Location safe = lobby.getSpawnLocation();
    
    for (Player p : Bukkit.getOnlinePlayers()) {
      p.teleport(safe);
    }

    // Waits 1 second to ensure players are fully disconnected from the old world chunks.
    Bukkit.getScheduler().runTaskLater(this, () -> {
      unloadAndDeleteWorld(WORLD_NAME);
      unloadAndDeleteWorld(NETHER_NAME);
      unloadAndDeleteWorld(END_NAME);

      Bukkit.getScheduler().runTaskLater(this, () -> {
        createGameWorlds();
        finishReset();
      }, 60L);
    }, 20L);
  }

  /**
   * Unloads and deletes the specified world directory from the disk.
   * Fixes pathing issues introduced in Paper 26.1 by dynamically retrieving the world folder.
   *
   * @param worldName The name of the world to delete.
   */
  private void unloadAndDeleteWorld(String worldName) {
    World world = Bukkit.getWorld(worldName);
    File worldFolder;

    if (world != null) {
      // Retrieves the exact file path dynamically (e.g. world/dimensions/minecraft/game)
      worldFolder = world.getWorldFolder();
      
      // Emergency kick for any players remaining to free the memory lock.
      for (Player p : world.getPlayers()) {
        p.teleport(Bukkit.getWorlds().get(0).getSpawnLocation());
      }
      
      boolean unloaded = Bukkit.unloadWorld(world, false);
      if (!unloaded) {
        getLogger().severe("Failed to unload world: " + worldName);
      }
    } else {
      // Fallback path specifically for Paper 26.1+ architecture if the world is already unloaded.
      worldFolder = new File(Bukkit.getWorldContainer(), "world/dimensions/minecraft/" + worldName);
    }
    
    if (!deleteFolder(worldFolder)) {
      getLogger().warning("Failed to fully delete world directory: " + worldFolder.getPath());
    }
  }


    /**
     * Generates fresh game worlds with a new random seed.
     */
  private void createGameWorlds() {
    long seed = new Random().nextLong();
    getLogger().info("Generating with seed: " + seed);

    WorldCreator overworld = new WorldCreator(WORLD_NAME);
    overworld.environment(World.Environment.NORMAL);
    overworld.seed(seed);
    overworld.createWorld();

    WorldCreator nether = new WorldCreator(NETHER_NAME);
    nether.environment(World.Environment.NETHER);
    nether.seed(seed);
    nether.createWorld();

    WorldCreator end = new WorldCreator(END_NAME);
    end.environment(World.Environment.THE_END);
    end.seed(seed);
    end.createWorld();
  }

  /**
   * Finishes the reset process, clears stats, and teleports players back to the new spawn.
   */
  private void finishReset() {
    World newWorld = Bukkit.getWorld(WORLD_NAME);
    if (newWorld == null) {
      getLogger().severe("Fatal Error: World not recreated.");
      return;
    }

    Location spawn = newWorld.getSpawnLocation();
    spawn.setY(newWorld.getHighestBlockYAt(spawn) + 1);

    currentRunTime = 0;
    totalRunDamage = 0.0;
    
    savePlayerData();

    for (Player p : Bukkit.getOnlinePlayers()) {
      resetPlayerState(p);
      p.teleport(spawn);
      p.sendMessage("§a§lTENTATIVE N°" + runCount + " ! BONNE CHANCE !");
      p.playSound(p.getLocation(), Sound.ENTITY_PLAYER_LEVELUP, 1, 1);
    }

    resetting = false;
  }

  /**
   * Resets a player's physical state, inventory, and advancements.
   *
   * @param p The target player.
   */
  private void resetPlayerState(Player p) {
    p.setGameMode(GameMode.SURVIVAL);
    p.setHealth(20);
    p.setFoodLevel(20);
    p.setSaturation(20);
    p.getInventory().clear();
    p.setExp(0);
    p.setLevel(0);
    p.getActivePotionEffects().forEach(e -> p.removePotionEffect(e.getType()));

    Iterator<Advancement> iterator = Bukkit.getServer().advancementIterator();
    while (iterator.hasNext()) {
      Advancement progress = iterator.next();
      AdvancementProgress pProgress = p.getAdvancementProgress(progress);
      for (String criteria : pProgress.getAwardedCriteria()) {
        pProgress.revokeCriteria(criteria);
      }
    }
  }

  /**
   * Handles custom portal logic to properly connect the generated game worlds.
   *
   * @param event The player portal event.
   */
  @EventHandler
  public void onPlayerPortal(PlayerPortalEvent event) {
    World fromWorld = event.getFrom().getWorld();
    if (fromWorld == null) {
      return;
    }

    if (event.getCause() == PlayerTeleportEvent.TeleportCause.NETHER_PORTAL) {
      if (fromWorld.getName().equals(WORLD_NAME)) {
        World nether = Bukkit.getWorld(NETHER_NAME);
        if (nether != null) {
          Location to = event.getFrom().clone();
          to.setWorld(nether);
          to.setX(to.getX() / 8);
          to.setZ(to.getZ() / 8);
          event.setTo(to);
        }
      } else if (fromWorld.getName().equals(NETHER_NAME)) {
        World overworld = Bukkit.getWorld(WORLD_NAME);
        if (overworld != null) {
          Location to = event.getFrom().clone();
          to.setWorld(overworld);
          to.setX(to.getX() * 8);
          to.setZ(to.getZ() * 8);
          event.setTo(to);
        }
      }
    } else if (event.getCause() == PlayerTeleportEvent.TeleportCause.END_PORTAL) {
      if (fromWorld.getName().equals(WORLD_NAME)) {
        World end = Bukkit.getWorld(END_NAME);
        if (end != null) {
          Location loc = new Location(end, 100, 50, 0);
          event.setTo(loc);
        }
      } else if (fromWorld.getName().equals(END_NAME)) {
        World overworld = Bukkit.getWorld(WORLD_NAME);
        if (overworld != null) {
          event.setTo(overworld.getSpawnLocation());
        }
      }
    }
  }

  /**
   * Ensures joining players receive the scoreboard and are teleported if outside the game worlds.
   *
   * @param e The player join event.
   */
  @EventHandler
  public void onJoin(PlayerJoinEvent e) {
    e.getPlayer().setScoreboard(scoreboard);
    int deaths = playerDeaths.getOrDefault(e.getPlayer().getUniqueId(), 0);
    updateScoreboard(e.getPlayer(), deaths);

    if (activePotionBossBar != null) {
      activePotionBossBar.addPlayer(e.getPlayer());
    }

    World game = Bukkit.getWorld(WORLD_NAME);
    if (game != null && !e.getPlayer().getWorld().equals(game)
        && !e.getPlayer().getWorld().getName().contains("game_")) {
      e.getPlayer().teleport(game.getSpawnLocation());
    }
  }

  /**
   * Recursively deletes a file or directory.
   *
   * @param folder The target directory.
   * @return True if deletion was successful.
   */
  private boolean deleteFolder(File folder) {
    if (folder.exists()) {
      File[] files = folder.listFiles();
      if (files != null) {
        for (File file : files) {
          if (file.isDirectory()) {
            deleteFolder(file);
          } else {
            file.delete();
          }
        }
      }
    }
    return folder.delete();
  }

  /**
   * Formats a total seconds value into a readable string (HHh MMm SSs).
   *
   * @param seconds Total seconds elapsed.
   * @return Formatted time string.
   */
  private String formatTime(int seconds) {
    return String.format("%02dh %02dm %02ds", seconds / 3600, (seconds % 3600) / 60, seconds % 60);
  }

  /**
   * Loads previously saved player statistics and game state from the configuration file.
   */
  private void loadPlayerData() {
    currentRunTime = getConfig().getInt("timer", 0);
    runCount = getConfig().getInt("run-count", 1);
    totalRunDamage = getConfig().getDouble("total-damage", 0.0);
    getLogger().info("Time loaded: " + formatTime(currentRunTime) + " | Run N°" + runCount);

    if (getConfig().contains("player-deaths")) {
      for (String key : getConfig().getConfigurationSection("player-deaths").getKeys(false)) {
        try {
          playerDeaths.put(UUID.fromString(key), getConfig().getInt("player-deaths." + key));
        } catch (IllegalArgumentException e) {
          // Exception ignored intentionally.
        }
      }
    }
  }

  /**
   * Saves player statistics and game state to the configuration file.
   */
  private void savePlayerData() {
    getConfig().set("timer", currentRunTime);
    getConfig().set("run-count", runCount);
    getConfig().set("total-damage", totalRunDamage);
    for (Map.Entry<UUID, Integer> entry : playerDeaths.entrySet()) {
      getConfig().set("player-deaths." + entry.getKey().toString(), entry.getValue());
    }
    saveConfig();
  }

  /**
   * Increments the death counter for a specific player and updates their scoreboard.
   *
   * @param p The dead player.
   */
  private void incrementPlayerDeath(Player p) {
    int d = playerDeaths.getOrDefault(p.getUniqueId(), 0) + 1;
    playerDeaths.put(p.getUniqueId(), d);
    updateScoreboard(p, d);
  }

  /**
   * Processes registered administrative commands for the plugin.
   */
  @Override
  public boolean onCommand(CommandSender sender, Command cmd, String label, String[] args) {
    if (cmd.getName().equalsIgnoreCase("forcereset") && sender.hasPermission("resetmap.admin")) {
      if (!resetting) resetGameWorlds();
      return true;
    } else if (cmd.getName().equalsIgnoreCase("setattempts") && sender.hasPermission("resetmap.admin")) {
      if (args.length == 1) {
        try {
          int newCount = Integer.parseInt(args[0]);
          if (newCount > 0) {
            this.runCount = newCount;
            savePlayerData();
            sender.sendMessage("§aLe compteur de tentatives a ete defini sur " + newCount);

            String timeString = formatTime(currentRunTime);
            for (Player p : Bukkit.getOnlinePlayers()) {
              p.setPlayerListFooter("§eTemps: §f" + timeString + " §7| §6Tentative N°: §f" + runCount);
            }
          } else {
            sender.sendMessage("§cLe nombre doit etre superieur a 0.");
          }
        } catch (NumberFormatException e) {
          sender.sendMessage("§cCe n'est pas un nombre valide.");
        }
      } else {
        sender.sendMessage("§cUtilisation: /setattempts <nombre>");
      }
      return true;
    } else if (cmd.getName().equalsIgnoreCase("editdeaths") && sender.hasPermission("resetmap.admin")) {
      if (args.length < 2) {
        sender.sendMessage("§cUsage: /editdeaths <joueur> <set|remove|add|reset> [nombre]");
        return true;
      }

      Player target = Bukkit.getPlayer(args[0]);
      if (target == null) {
        sender.sendMessage("§cJoueur introuvable ou hors ligne.");
        return true;
      }

      String action = args[1].toLowerCase();
      int currentDeaths = playerDeaths.getOrDefault(target.getUniqueId(), 0);
      int newDeaths = currentDeaths;

      try {
        if (action.equals("reset")) {
          newDeaths = 0;
        } else {
          if (args.length < 3) {
            sender.sendMessage("§cVeuillez specifier un nombre. Ex: /editdeaths Pseudo remove 1");
            return true;
          }
          int amount = Integer.parseInt(args[2]);

          if (action.equals("set")) {
            newDeaths = Math.max(0, amount);
          } else if (action.equals("remove")) {
            newDeaths = Math.max(0, currentDeaths - amount);
          } else if (action.equals("add")) {
            newDeaths = currentDeaths + amount;
          } else {
            sender.sendMessage("§cAction inconnue. Utilisez: set, remove, add, reset");
            return true;
          }
        }

        playerDeaths.put(target.getUniqueId(), newDeaths);
        updateScoreboard(target, newDeaths);
        savePlayerData();

        sender.sendMessage("§aSucces ! §fCompteur de " + target.getName() + " modifie : §c"
            + currentDeaths + " ➔ " + newDeaths);

      } catch (NumberFormatException e) {
        sender.sendMessage("§cErreur : Le nombre specifie n'est pas valide.");
      }
      return true;
    } else if (cmd.getName().equalsIgnoreCase("listeffects") && sender.hasPermission("resetmap.admin")) {
      sender.sendMessage("§eRegarde la console pour la liste complete !");
      getLogger().info("=== LISTE DES EFFETS DETECTES ===");

      int count = 0;
      for (PotionEffectType type : PotionEffectType.values()) {
        if (type != null) {
          getLogger().info("- " + type.getName() + " (ID: " + type.getKey() + ")");
          count++;
        }
      }
      getLogger().info("=== TOTAL: " + count + " EFFETS ===");
      return true;
    }
    return false;
  }
}