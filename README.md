# The Ballad of Lorbert

NOTE: The Ballad of Lorbert was originally called The Ballad of Sigurd. We have been lazy in our approach to renaming everything so where you see Sigurd, please substitute Lorbert.

## Getting Started

The Ballad of Lorbert is a tech demo designed to show how a game developer might integrate with the Planet Nine Platform. It utilizes the Planet Nine Gateway cocoapod found here: [PlanetNineGateway](https://github.com/planet-nine-app/iOS-PlanetNineGateway-Framework). As the cocoapod covers implementation details, we will assume that if you're using this repository, you're already familiar with PlanetNineGateway. We also assume you are familiar with the Planet Nine Platform and its resources Power and Nineum. For more information about the Planet Nine Platform please refer to the Planet Nine whitepaper located here: <TODO: Add link once available>. 

The Ballad of Lorbert is a simple demo of an RPG that uses Nineum as inventory items, and presents the user with a special power button to spend Power with. The Ballad consists of three screens. The first is a welcome screen that allows a user to connect their Planet Nine account to The Ballad of Lorbert. This utilizes the ongoing-gateway API in PlanetNineGateway and will grant The Ballad of Lorbert permission to make Power expenditures on the user's behalf. 

Once an account has been connected, the user can tap the Play button, which will launch the inventory selection screen. In inventory selection the user can choose a character and equip Nineum to eight different equipment slots. The equipment that is equipped will increase the stats of the character. The inventory system uses the size trait of Nineum to determine what type of equipment it is (weapon, helm, body armor, etc.). Next the inventory system uses the shape trait to pick which stat the equipment influences (agility, strength, wisdom, etc). The inventory system then uses the rarity, charge, and direction traits to determine the stat modification value. 

After equipping all of the desired equipment, the user can exit the inventory screen and enter the battle screen. Characters can be selected by tapping them and then can attack by tapping on the sludge monster. At the top of the screen, there is a button that says "Special Power: 300 Power". Tapping that will use the special power and spend 300 Power on the behalf of the player. Spending Power in this way will result in the player receiving a Nineum, and the game developer getting a 50% chance of receiving Nineum (that's for 300 Power. At 400 Power the game developer will receive one Nineum all of the time, and for 600 Nineum the game developer will receive two Nineum). 

And that's all there is to the tech demo. This code is provided open source and is available for anyone to download and run. We hope that it helps clear up some of the implementation details of using Nineum and Power in games. 
