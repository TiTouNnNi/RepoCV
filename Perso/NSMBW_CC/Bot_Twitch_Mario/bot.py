"""Twitch bot for New Super Mario Bros. Wii Crowd Control."""

import time
import asyncio
import sys
import twitchio
from twitchio.ext import commands
import pydirectinput
import dolphin_memory_engine

# Memory addresses matching the C++ Kamek hook (Zone 0x17E0).
KAMEK_SPAWN_TARGET = 0x800017E0
KAMEK_SPAWN_SETTINGS = 0x800017E4
KAMEK_SPEED_MULTIPLIER = 0x8000100C

# Official NSMBW Actor IDs.
ACTOR_SPAWN_DICT = {
    "mushroom": (105, 0), "fireflower": (105, 1), "minimushroom": (105, 2),
    "propeller": (105, 3), "penguin": (105, 4), "iceflower": (105, 5),
    "star": (105, 6), "1up": (105, 7), 
    "goomba": (108, 0), "koopa": (109, 0), 
    "bobomb": (123, 0), "thwomp": (163, 0), "bowser": (257, 0)
}

class StreamInteractBot(commands.Bot):
    """Main bot class handling Twitch interactions and Dolphin memory injection."""

    def __init__(self):
        """Initializes the bot with credentials and cooldown trackers."""
        super().__init__(
            token='oauth:bik6lspkcdqwf86u0fbo8jpecmifzr',
            prefix='!',
            initial_channels=['tit0uni']
        )
        self.cooldowns = {"bowser": 0.0, "double": 0.0}

    async def event_ready(self):
        """Triggered when the bot successfully connects to Twitch."""
        print(f'✅ Bot connected to Twitch as: {self.nick}')
        if not dolphin_memory_engine.is_hooked():
            dolphin_memory_engine.hook()
            if dolphin_memory_engine.is_hooked():
                print("✅ Successfully hooked to Dolphin memory.")
            else:
                print("⚠️ Dolphin not found. Please start the game!")

    async def event_message(self, message):
        """Processes incoming chat messages."""
        if message.echo:
            return
        print(f"[CHAT] {message.author.name}: {message.content}")
        await self.handle_commands(message)

    @commands.command(name="spawn")
    async def spawn_entity(self, ctx: commands.Context, entity_name: str):
        """Spawns an in-game entity based on viewer commands. Restricted to VIP/Mods."""
        # Anti-spam security: only broadcaster, moderators, or VIPs can trigger this.
        if not (ctx.author.is_broadcaster or ctx.author.is_mod or ctx.author.is_vip):
            await ctx.send(f"@{ctx.author.name}, Crowd Control is reserved for VIPs and Mods!")
            return

        entity_name = entity_name.lower()
        if entity_name not in ACTOR_SPAWN_DICT:
            await ctx.send(f"Unknown entity! Available: {', '.join(ACTOR_SPAWN_DICT.keys())}")
            return
            
        actor_id, settings = ACTOR_SPAWN_DICT[entity_name]

        # Enforce a 5-minute cooldown specifically for Bowser.
        if entity_name == "bowser":
            current_time = time.time()
            if current_time < self.cooldowns["bowser"]:
                await ctx.send("Bowser is on a 5-minute cooldown!")
                return
            self.cooldowns["bowser"] = current_time + 300.0

        # Inject commands into Wii memory if Dolphin is attached.
        if dolphin_memory_engine.is_hooked():
            dolphin_memory_engine.write_word(KAMEK_SPAWN_SETTINGS, settings)
            dolphin_memory_engine.write_word(KAMEK_SPAWN_TARGET, actor_id)
            await ctx.send(f"A wild {entity_name} appears!")
        else:
            await ctx.send("Error: Emulator is not connected.")

    @commands.command(name='jump')
    async def jump_command(self, ctx: commands.Context):
        """Simulates a spacebar press to make Mario jump."""
        pydirectinput.press('space') 
        await ctx.send(f"YAHOO! {ctx.author.name} made Mario jump!")

    @commands.command(name="double")
    async def double_cmd(self, ctx: commands.Context):
        """Doubles Mario's speed for 10 seconds. Restricted to VIP/Mods."""
        if not (ctx.author.is_broadcaster or ctx.author.is_mod or ctx.author.is_vip):
            return
            
        current_time = time.time()
        if current_time < self.cooldowns["double"]:
            time_left = int(self.cooldowns["double"] - current_time)
            await ctx.send(f"⏳ !double is on cooldown: {time_left}s left.")
            return

        self.cooldowns["double"] = current_time + 30.0

        if dolphin_memory_engine.is_hooked():
            dolphin_memory_engine.write_float(KAMEK_SPEED_MULTIPLIER, 2.0)
            await ctx.send(f"⚡ 2x Speed activated for 10s!")
            await asyncio.sleep(10.0)
            if dolphin_memory_engine.is_hooked():
                dolphin_memory_engine.write_float(KAMEK_SPEED_MULTIPLIER, 1.0)
                await ctx.send("2x Speed ended!")

if __name__ == '__main__':
    # Windows-specific event loop policy patch for Python 3.10+
    if sys.platform == 'win32':
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    
    bot = StreamInteractBot()
    bot.run()