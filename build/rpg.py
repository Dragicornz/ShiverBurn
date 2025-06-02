import random
import time

player = {
    "name": "Hero",
    "hp": 30,
    "attack": (4, 8)
}

monsters = [
    {"name": "Goblin", "hp": 10, "attack": (2, 4)},
    {"name": "Slime", "hp": 12, "attack": (1, 3)},
    {"name": "Orc", "hp": 15, "attack": (3, 6)},
]

def fight(monster):
    print(f"\n⚔  A wild {monster['name']} appears!")
    time.sleep(1)
    while monster["hp"] > 0 and player["hp"] > 0:
        input("\n Press Enter to attack")
        player_hit = random.randint(*player["attack"])
        monster["hp"] -= player_hit
        print(f"You hit the {monster['name']} for {player_hit} damage!")

        if monster["hp"] <= 0:
            print(f" You defeated the {monster['name']}!")
            break

        monster_hit = random.randint(*monster["attack"])
        player["hp"] -= monster_hit
        print(f"The {monster['name']} hits you for {monster_hit} damage!")

        print(f"Your HP: {player['hp']} | {monster['name']} HP: {monster['hp']}")

    if player["hp"] <= 0:
        print("\n You have been defeated...")
        return False
    return True

def game_loop():
    print(" Welcome to MiniRPG!\n")
    while player["hp"] > 0:
        monster = random.choice(monsters)
        result = fight(monster)
        if not result:
            break
        cont = input("\n Fight again? (y/n): ").lower()
        if cont != 'y':
            break
    print("\n Game Over. Thanks for playing!")

game_loop()
