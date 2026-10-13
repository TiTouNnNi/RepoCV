#include <cstdint>
#include <game.h>
#include <kamek.h>

// Secure memory addresses bypassing the CPU cache (using 0xC0).
volatile uint32_t* const kTwitchSpawnTarget = reinterpret_cast<uint32_t*>(0xC00017E0);
volatile uint32_t* const kTwitchSpawnSettings = reinterpret_cast<uint32_t*>(0xC00017E4);
volatile uint32_t* const kTwitchDebug = reinterpret_cast<uint32_t*>(0xC00017EC);

static uint32_t rng_seed = 987654321;
static float last_direction = 1.0f;

// EXPLICIT OPTIMIZATION FLAG: Forces O2 instead of Os for this function.
// This prevents GCC from generating calls to missing libgcc helpers.
extern "C" __attribute__((optimize("O2"))) void ExecuteTwitchCommands() {
    // Alive signal to prove execution.
    *kTwitchDebug = 777;

    uint32_t requested_actor_id = *kTwitchSpawnTarget;
    
    // Exit immediately if no command is pending.
    if (requested_actor_id == 0) {
        return;
    }

    uint32_t requested_settings = *kTwitchSpawnSettings;
    
    // Clear the memory flags IMMEDIATELY to prevent phantom spawns 
    // from lingering commands during loading screens or world maps.
    *kTwitchSpawnTarget = 0;
    *kTwitchSpawnSettings = 0;

    // Retrieve Player 1 using the engine's built-in function (automatically linked).
    dAc_Py_c* mario = GetSpecificPlayerActor(0);
    
    // Safety boundary check to ensure the pointer is within valid game heap memory.
    if (!mario || reinterpret_cast<uint32_t>(mario) < 0x80000000 || reinterpret_cast<uint32_t>(mario) > 0x81800000) {
        return;
    }

    // Read speed strictly during active gameplay.
    if (mario->speed.x > 0.5f) {
        last_direction = 1.0f;
    } else if (mario->speed.x < -0.5f) {
        last_direction = -1.0f;
    }

    // Generate pseudo-random distance.
    rng_seed = rng_seed * 1664525 + 1013904223;
    float random_distance = 150.0f + static_cast<float>(rng_seed % 200);

    VEC3 spawn_pos;
    spawn_pos.x = mario->pos.x + (random_distance * last_direction);
    spawn_pos.y = mario->pos.y + 120.0f; 
    spawn_pos.z = mario->pos.z;

    // Provide a default rotation to avoid null pointer crashes.
    int16_t rot[3] = {0, 0, 0};
    
    // Spawn the actor using the engine's built-in function.
    CreateActor(static_cast<Actors>(requested_actor_id), requested_settings, &spawn_pos, &rot, 0);
}

// -------------------------------------------------------------
// GCC-COMPATIBLE ASSEMBLY TRAMPOLINE
// Secure context switch preserving volatile registers.
// -------------------------------------------------------------
asm(
    ".global MyHook\n"
    "MyHook:\n"
    "stw 0, 12(1)\n"          
    "stwu 1, -0x80(1)\n"      
    "mflr 0\n"
    "stw 0, 0x84(1)\n"        
    "stw 3, 0x08(1)\n"        
    "stw 4, 0x0C(1)\n"
    "stw 5, 0x10(1)\n"
    "stw 6, 0x14(1)\n"
    "stw 7, 0x18(1)\n"
    "stw 8, 0x1C(1)\n"
    "stw 9, 0x20(1)\n"
    "stw 10, 0x24(1)\n"
    "stw 11, 0x28(1)\n"
    "stw 12, 0x2C(1)\n"
    
    "bl ExecuteTwitchCommands\n" 
    
    "lwz 3, 0x08(1)\n"        
    "lwz 4, 0x0C(1)\n"
    "lwz 5, 0x10(1)\n"
    "lwz 6, 0x14(1)\n"
    "lwz 7, 0x18(1)\n"
    "lwz 8, 0x1C(1)\n"
    "lwz 9, 0x20(1)\n"
    "lwz 10, 0x24(1)\n"
    "lwz 11, 0x28(1)\n"
    "lwz 12, 0x2C(1)\n"
    "lwz 0, 0x84(1)\n"
    "mtlr 0\n"                
    "addi 1, 1, 0x80\n"       
    
    "lis 12, 0x8000\n"        
    "ori 12, 12, 0xA188\n"    
    "mtctr 12\n"              
    "bctr\n"                  
);

// Instruct Kamek to overwrite 0x8000A184 to branch to our trampoline.
extern "C" void MyHook();
kmBranch(0x8000A184, MyHook);