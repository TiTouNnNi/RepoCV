import logging
import twitchio
from twitchio.ext import commands

# 1. On active le mode Rayon X pour voir le dialogue brut avec Twitch
logging.basicConfig(level=logging.DEBUG)

class TestBot(commands.Bot):
    def __init__(self):
        super().__init__(
            # ESSAIE SANS "oauth:" CETTE FOIS-CI ! (Juste bik6lspkcdqwf...)
            token='bik6lspkcdqwf86u0fbo8jpecmifzr',
            prefix='!',
            client_id='c89n9it0p289lv9dddhf9meo4ywzio',
            client_secret='q828kspv2xjv929u0yfw5f7ex3ta5y',
            initial_channels=['tit0uni']
        )

    async def event_ready(self):
        print("✅ CONNECTÉ AU SERVEUR TWITCH !")
        try:
            if hasattr(self, 'join'):
                await self.join('tit0uni')
            elif hasattr(self, 'join_channels'):
                await self.join_channels(['tit0uni'])
        except Exception as e:
            print(f"❌ ERREUR JOIN : {e}")

    async def event_message(self, message):
        try:
            if message.echo:
                return
            print(f"[CHAT] Message reçu : {message.content}")
            if message.content.lower() == "!ping":
                await message.channel.send("Pong !")
        except Exception as e:
            print(f"❌ ERREUR MESSAGE : {e}")

bot = TestBot()
bot.run()