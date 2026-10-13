class Character:

    def __init__(self, pv, x, y, isClose):

        self.pv = pv

        self.x = x

        self.y = y

        self.isClose = isClose

warrior = Character(3,1,1,False)

mage = Character(3,1,1,False)

healer = Character(3,1,1,False)

bowman = Character(3,1,1,False)

if warrior.isClose == False:

