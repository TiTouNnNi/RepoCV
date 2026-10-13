(define (problem navigate-to-location)
   (:domain action-castle)

   (:objects
      npc - player
      cottage gardenpath fishingpond gardenpath windingpath talltree drawbridge courtyard towerstairs tower dungeonstairs dungeon greatfeastinghall throneroom - location
      in out north south east west up down - direction
      branch rose fishingrod crown food candle - item
      fish - food
      bowser - monster
      princess guard - character
   )

   (:init
      (connected cottage out gardenpath)
      (connected gardenpath in cottage)
      (connected gardenpath south fishingpond)
      (connected fishingpond north gardenpath)
      (connected gardenpath north windingpath)
      (connected windingpath south gardenpath)
      (connected windingpath up talltree)
      (connected talltree down windingpath)
      (connected windingpath east drawbridge)
      (connected drawbridge west windingpath)
      (connected drawbridge east courtyard)
      (connected courtyard west drawbridge)
      (connected courtyard up towerstairs)
      (connected towerstairs down courtyard)
      (connected towerstairs up tower)
      (connected tower down towerstairs)
      (connected courtyard down dungeonstairs)
      (connected dungeonstairs up courtyard)
      (connected dungeonstairs down dungeon)
      (connected dungeon up dungeonstairs)
      (connected courtyard east greatfeastinghall)
      (connected greatfeastinghall west courtyard)
      (connected greatfeastinghall east throneroom)
      (connected throneroom west greatfeastinghall)
      (haslake fishingpond)
      (at npc cottage)
      (at crown tower)
      (at fishingrod drawbridge)
      (at bowser dungeonstairs)
      (blocked dungeonstairs down dungeon)
      (hungry bowser)
      (at rose gardenpath)
      (at princess tower)
      (at branch talltree)
      (weapon branch)
      (at guard courtyard)
      (blocked courtyard up towerstairs)
      (at candle greatfeastinghall)
      (blocked dungeonstairs down dungeon)
      (dark dungeon)
      (at ghost dungeon)
   )

   (:goal (and (has princess rose) (at npc tower)))
)