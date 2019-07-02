extends Node

#player data = inventory
#3 separate save files per player at present.
var url_PlayerData = "user://PlayerData.bin"
var url_PlayerEquiped = "user://PlayerEquiped.bin"
var url_PlayerStats = "user://PlayerStats.bin"
#how to make save files into single save file?

#setup for files for other save slots
var url_PlayerData_02 = "user://PlayerData02.bin"
var url_PlayerEquiped_02 = "user://PlayerEquiped02.bin"
var url_PlayerStats_02 = "user://PlayerStats02.bin"

var url_PlayerData_03 = "user://PlayerData03.bin"
var url_PlayerEquiped_03 = "user://PlayerEquiped03.bin"
var url_PlayerStats_03 = "user://PlayerStats03.bin"

var url_PlayerData_04 = "user://PlayerData04.bin"
var url_PlayerEquiped_04 = "user://PlayerEquiped04.bin"
var url_PlayerStats_04 = "user://PlayerStats04.bin"

var url_savefile_status = "user://SaveFiles.bin"

var url_options_data = "user://OptionsFile.bin"

var url_game_data = "user://GameData.bin"

var url_arena_scoreboard = "user://ArenaScoreboard.bin"

onready var gameData = Global_DataParser.load_data(url_game_data)

onready var arena_scoreboard_data = Global_DataParser.load_data(url_arena_scoreboard)

var inventory = {}
var inventory_maxSlots = 45 

#shop inventory vars. Reset at certain scenes, eg charcater selection
var shop_inventory = {}
var shop_inventory_maxSlots = 54

#original from inventory
onready var playerData = Global_DataParser.load_data(url_PlayerData)
onready var playerEquiped = Global_DataParser.load_data(url_PlayerEquiped)
onready var playerStats = Global_DataParser.load_data(url_PlayerStats)

onready var playerData2 = Global_DataParser.load_data(url_PlayerData_02)
onready var playerEquiped2 = Global_DataParser.load_data(url_PlayerEquiped_02)
onready var playerStats2 = Global_DataParser.load_data(url_PlayerStats_02)

onready var playerData3 = Global_DataParser.load_data(url_PlayerData_03)
onready var playerEquiped3 = Global_DataParser.load_data(url_PlayerEquiped_03)
onready var playerStats3 = Global_DataParser.load_data(url_PlayerStats_03)

onready var playerData4 = Global_DataParser.load_data(url_PlayerData_04)
onready var playerEquiped4 = Global_DataParser.load_data(url_PlayerEquiped_04)
onready var playerStats4 = Global_DataParser.load_data(url_PlayerStats_04)

var equiped_items = {}
var player_stats = {}

var coin_counter = 0
var coin_itemID = 27

var normal_arrow_counter = 0
var normal_arrow_itemID = 11

var torches_itemID = 38

var inventory_equiped_items = {
	inventory_weapons1 = -1,
	inventory_weapons1_upgrades = 0,
	inventory_weapons2 = -1,
	inventory_weapons2_upgrades = 0,
	inventory_weapons3 = -1,
	inventory_weapons3_upgrades = 0,
	inventory_armour1 = -1,
	inventory_armour1_upgrades = 0,
	inventory_helmet1 = -1,
	inventory_shield1 = -1,
	inventory_shield1_upgrades = 0,
	inventory_items1 = -1,
	inventory_items1_amount = -1,
	inventory_items2 = -1,
	inventory_items2_amount = -1,
	inventory_items3 = -1,
	inventory_items3_amount = -1,
	inventory_items4 = -1,
	inventory_items4_amount = -1,
	inventory_items5 = -1,
	inventory_items5_amount = -1,
	inventory_items6 = -1,
	inventory_items6_amount = -1
}

var player_stats_to_save = PlayerData.Player_Information

var save_file_status = {
	file01 = false,
	file02 = false,
	file03 = false,
	file04 = false
}

onready var save_files = Global_DataParser.load_data(url_savefile_status)

var save_file01_info = {}
var save_file02_info = {}
var save_file03_info = {}
var save_file04_info = {}

onready var options_file = Global_DataParser.load_data(url_options_data)

func _ready():
	load_data()
	reset_shop_stock()
	#reset shop so there are not multiple copies of items
	#add weapons to the shop
	shop_addItem(1, 1, 0)
	shop_addItem(3, 1, 0)
	shop_addItem(5, 1, 0)
	shop_addItem(7, 1, 0)
	shop_addItem(9, 1, 0)
	shop_addItem(10, 1, 0)
	shop_addItem(11, 1, 0)
	shop_addItem(2, 1, 0)
	shop_addItem(4, 1, 0)
	shop_addItem(6, 1, 0)
	shop_addItem(8, 1, 0)
	
	shop_addItem(16, 1, 0)
	shop_addItem(17, 1, 0)
	shop_addItem(18, 1, 0)
	shop_addItem(39, 1, 0)
	shop_addItem(40, 1, 0)
	shop_addItem(41, 1, 0)
	shop_addItem(42, 1, 0)
	
	shop_addItem(28, 1, 0)
	shop_addItem(29, 1, 0)
	shop_addItem(30, 1, 0)
	shop_addItem(32, 1, 0)
	shop_addItem(34, 1, 0)
	shop_addItem(35, 1, 0)
	shop_addItem(36, 1, 0)
	shop_addItem(37, 1, 0)
	shop_addItem(38, 1, 0)

#initial setup of files
func load_data():
	if (gameData == null):
		gameData = PlayerData.Game_Data
		Global_DataParser.write_data(url_game_data, gameData)
	else:
		PlayerData.Game_Data = gameData
		print ("Game Data: ", gameData)
	
	if (arena_scoreboard_data == null):
		arena_scoreboard_data = PlayerData.arena_scores
		Global_DataParser.write_data(url_arena_scoreboard, arena_scoreboard_data)
	else:
		PlayerData.arena_scores = arena_scoreboard_data
	
	if (options_file == null):
		options_file = PlayerData.Options_Data
		Global_DataParser.write_data(url_options_data, options_file)
	else:
		PlayerData.Options_Data = options_file
		print ("Options Files: ", options_file)
	if (save_files == null):
		save_files = save_file_status
		Global_DataParser.write_data(url_savefile_status, save_files)
	else:
		save_file_status = save_files
		print ("Save File Status: ", save_file_status)
	if (playerData == null):
		var dict = {"inventory":{}}
		for slot in range (0, inventory_maxSlots):
			dict["inventory"][String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		Global_DataParser.write_data(url_PlayerData, dict)
		inventory = dict["inventory"]
	else:
		inventory = playerData["inventory"]
	if (playerEquiped == null):
		var dict2 = {"equiped":{}}
		dict2["equiped"][String()] = {inventory_equiped_items:-1}
		Global_DataParser.write_data(url_PlayerEquiped, dict2)
		equiped_items = dict2["equiped"]
	else:
		equiped_items = playerEquiped["equiped"]
		inventory_equiped_items = equiped_items
	
	if (playerStats == null):
		var dict3 = {"stats":{}}
		dict3["stats"][String()] = {}
		Global_DataParser.write_data(url_PlayerStats, dict3)
		player_stats = dict3["stats"]
	else:
		player_stats = playerStats["stats"]
		player_stats_to_save = player_stats
		PlayerData.Player_Information = player_stats_to_save
	#new file attempts VVVV
	if (playerData2 == null):
		var dict = {"inventory":{}}
		for slot in range (0, inventory_maxSlots):
			dict["inventory"][String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		Global_DataParser.write_data(url_PlayerData_02, dict)
		inventory = dict["inventory"]
	else:
		inventory = playerData2["inventory"]
	if (playerEquiped2 == null):
		var dict2 = {"equiped":{}}
		dict2["equiped"][String()] = {inventory_equiped_items:-1}
		Global_DataParser.write_data(url_PlayerEquiped_02, dict2)
		equiped_items = dict2["equiped"]
	else:
		equiped_items = playerEquiped2["equiped"]
		inventory_equiped_items = equiped_items
	
	if (playerStats2 == null):
		var dict3 = {"stats":{}}
		dict3["stats"][String()] = {}
		Global_DataParser.write_data(url_PlayerStats_02, dict3)
		player_stats = dict3["stats"]
	else:
		player_stats = playerStats2["stats"]
		player_stats_to_save = player_stats
		PlayerData.Player_Information = player_stats_to_save
	if (playerData3 == null):
		var dict = {"inventory":{}}
		for slot in range (0, inventory_maxSlots):
			dict["inventory"][String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		Global_DataParser.write_data(url_PlayerData_03, dict)
		inventory = dict["inventory"]
	else:
		inventory = playerData3["inventory"]
	
	if (playerEquiped3 == null):
		var dict2 = {"equiped":{}}
		dict2["equiped"][String()] = {inventory_equiped_items:-1}
		Global_DataParser.write_data(url_PlayerEquiped_03, dict2)
		equiped_items = dict2["equiped"]
	else:
		equiped_items = playerEquiped3["equiped"]
		inventory_equiped_items = equiped_items
	
	if (playerStats3 == null):
		var dict3 = {"stats":{}}
		dict3["stats"][String()] = {}
		Global_DataParser.write_data(url_PlayerStats_03, dict3)
		player_stats = dict3["stats"]
	else:
		player_stats = playerStats3["stats"]
		PlayerData.Player_Information = player_stats#_to_save #why did i modify this one? testing for reduced steps
	
	if (playerData4 == null):
		var dict = {"inventory":{}}
		for slot in range (0, inventory_maxSlots):
			dict["inventory"][String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		Global_DataParser.write_data(url_PlayerData_04, dict)
		inventory = dict["inventory"]
	else:
		inventory = playerData4["inventory"]
	
	if (playerEquiped4 == null):
		var dict2 = {"equiped":{}}
		dict2["equiped"][String()] = {inventory_equiped_items:-1}
		Global_DataParser.write_data(url_PlayerEquiped_04, dict2)
		equiped_items = dict2["equiped"]
	else:
		equiped_items = playerEquiped4["equiped"]
		inventory_equiped_items = equiped_items
	
	if (playerStats4 == null):
		var dict3 = {"stats":{}}
		dict3["stats"][String()] = {}
		Global_DataParser.write_data(url_PlayerStats_04, dict3)
		player_stats = dict3["stats"]
	else:
		player_stats = playerStats4["stats"]
		player_stats_to_save = player_stats
		PlayerData.Player_Information = player_stats_to_save

func load_file01():
	inventory = playerData["inventory"]
	
	equiped_items = playerEquiped["equiped"]
	inventory_equiped_items = equiped_items
	
	player_stats = playerStats["stats"]
	player_stats_to_save = player_stats
	PlayerData.Player_Information = player_stats_to_save

func load_file02():
	inventory = playerData2["inventory"]
	
	equiped_items = playerEquiped2["equiped"]
	inventory_equiped_items = equiped_items
	
	player_stats = playerStats2["stats"]
	player_stats_to_save = player_stats
	PlayerData.Player_Information = player_stats_to_save

func load_file03():
	inventory = playerData3["inventory"]
	
	equiped_items = playerEquiped3["equiped"]
	inventory_equiped_items = equiped_items
	
	player_stats = playerStats3["stats"]
	#player_stats_to_save = player_stats    #from testing
	PlayerData.Player_Information = player_stats#player_stats_to_save

func load_file04():
	inventory = playerData4["inventory"]
	
	equiped_items = playerEquiped4["equiped"]
	inventory_equiped_items = equiped_items
	
	player_stats = playerStats4["stats"]
	player_stats_to_save = player_stats
	PlayerData.Player_Information = player_stats_to_save

func load_info_to_display():
	save_file01_info = playerStats["stats"]
	save_file02_info = playerStats2["stats"]
	save_file03_info = playerStats3["stats"]
	save_file04_info = playerStats4["stats"]

func reset_data():
	for slot in range(0, inventory_maxSlots):
		inventory_removeItem_all(slot)
	
	inventory_equiped_items = {
		inventory_weapons1 = -1,
		inventory_weapons1_upgrades = 0,
		inventory_weapons2 = -1,
		inventory_weapons2_upgrades = 0,
		inventory_weapons3 = -1,
		inventory_weapons3_upgrades = 0,
		inventory_armour1 = -1,
		inventory_armour1_upgrades = 0,
		inventory_helmet1 = -1,
		inventory_shield1 = -1,
		inventory_shield1_upgrades = 0,
		inventory_items1 = -1,
		inventory_items1_amount = -1,
		inventory_items2 = -1,
		inventory_items2_amount = -1,
		inventory_items3 = -1,
		inventory_items3_amount = -1,
		inventory_items4 = -1,
		inventory_items4_amount = -1,
		inventory_items5 = -1,
		inventory_items5_amount = -1,
		inventory_items6 = -1,
		inventory_items6_amount = -1
	}

func delete_file_01():
	save_file_status.file01 = false
	save_files = save_file_status
	Global_DataParser.write_data(url_savefile_status, save_files)

func delete_file_02():
	save_file_status.file02 = false
	save_files = save_file_status
	Global_DataParser.write_data(url_savefile_status, save_files)

func delete_file_03():
	save_file_status.file03 = false
	save_files = save_file_status
	Global_DataParser.write_data(url_savefile_status, save_files)

func delete_file_04():
	save_file_status.file04 = false
	save_files = save_file_status
	Global_DataParser.write_data(url_savefile_status, save_files)

#original save
func save_data():
	player_stats_to_save = PlayerData.Player_Information
	equiped_items = inventory_equiped_items
	player_stats = player_stats_to_save
	Global_DataParser.write_data(url_PlayerData, {"inventory": inventory})
	Global_DataParser.write_data(url_PlayerEquiped, {"equiped": equiped_items})
	Global_DataParser.write_data(url_PlayerStats, {"stats": player_stats})

#new saves
func save_data_01():
	player_stats_to_save = PlayerData.Player_Information
	equiped_items = inventory_equiped_items
	player_stats = player_stats_to_save
	save_file_status.file01 = true
	save_files = save_file_status
	Global_DataParser.write_data(url_PlayerData, {"inventory": inventory})
	Global_DataParser.write_data(url_PlayerEquiped, {"equiped": equiped_items})
	Global_DataParser.write_data(url_PlayerStats, {"stats": player_stats})
	Global_DataParser.write_data(url_savefile_status, save_files)

func save_data_02():
	player_stats_to_save = PlayerData.Player_Information
	equiped_items = inventory_equiped_items
	player_stats = player_stats_to_save
	save_file_status.file02 = true
	save_files = save_file_status
	Global_DataParser.write_data(url_PlayerData_02, {"inventory": inventory})
	Global_DataParser.write_data(url_PlayerEquiped_02, {"equiped": equiped_items})
	Global_DataParser.write_data(url_PlayerStats_02, {"stats": player_stats})
	Global_DataParser.write_data(url_savefile_status, save_files)

func save_data_03():
	player_stats_to_save = PlayerData.Player_Information
	equiped_items = inventory_equiped_items
	player_stats = player_stats_to_save
	save_file_status.file03 = true
	save_files = save_file_status
	Global_DataParser.write_data(url_PlayerData_03, {"inventory": inventory})
	Global_DataParser.write_data(url_PlayerEquiped_03, {"equiped": equiped_items})
	Global_DataParser.write_data(url_PlayerStats_03, {"stats": player_stats})
	Global_DataParser.write_data(url_savefile_status, save_files)

func save_data_04():
	player_stats_to_save = PlayerData.Player_Information
	equiped_items = inventory_equiped_items
	player_stats = player_stats_to_save
	save_file_status.file04 = true
	save_files = save_file_status
	Global_DataParser.write_data(url_PlayerData_04, {"inventory": inventory})
	Global_DataParser.write_data(url_PlayerEquiped_04, {"equiped": equiped_items})
	Global_DataParser.write_data(url_PlayerStats_04, {"stats": player_stats})
	Global_DataParser.write_data(url_savefile_status, save_files)

#options save file
func save_options_data():
	Global_DataParser.write_data(url_options_data, PlayerData.Options_Data)

func check_if_inventory_is_full():
	var empty_slots_count = 0
	for slot in range (0, inventory_maxSlots):
		if (inventory[String(slot)]["id"] == "0"): 
			empty_slots_count += 1
	if empty_slots_count == 0:
		PlayerData.Player_Information.player_inventory_is_full = true
		print ("Empty Slots Count: ", empty_slots_count)
	elif empty_slots_count >= 1:
		PlayerData.Player_Information.player_inventory_is_full = false
		print ("Empty Slots Count: ", empty_slots_count)

func inventory_getEmptySlot():
	for slot in range(0, inventory_maxSlots):
		if (inventory[String(slot)]["id"] == "0"): 
			return int(slot)
	print ("Inventory is full!")
	return -1

func inventory_addItem(itemId, item_amount, item_upgrades):
	var itemData = Global_ItemDatabase.get_item(String(itemId))
	if (itemData == null): 
		return -1
	if (!itemData["stackable"]):
		var slot = inventory_getEmptySlot()
		if (slot < 0): 
			return -1
		if item_amount != null:
			inventory[String(slot)] = {"id": String(itemId), "amount": item_amount, "upgrades": item_upgrades}
		elif item_amount == null:
			inventory[String(slot)] = {"id": String(itemId), "amount": 1, "upgrades": item_upgrades}
		return slot
	for slot in range (0, inventory_maxSlots):
		if (inventory[String(slot)]["id"] == String(itemId)):
			if item_amount != null:
				inventory[String(slot)]["amount"] = int(inventory[String(slot)]["amount"] + item_amount)
				if (inventory[String(slot)]["id"] == String(normal_arrow_itemID)):
					normal_arrows_controller(inventory[String(slot)]["amount"])
			elif item_amount == null:
				inventory[String(slot)]["amount"] = int(inventory[String(slot)]["amount"] + 1)
				if (inventory[String(slot)]["id"] == String(normal_arrow_itemID)):
					normal_arrows_controller(inventory[String(slot)]["amount"])
			return slot
	var slot = inventory_getEmptySlot()
	if (slot < 0): 
		return -1
	if item_amount != null:
		inventory[String(slot)] = {"id": String(itemId), "amount": item_amount, "upgrades": item_upgrades}
		if (inventory[String(slot)]["id"] == String(normal_arrow_itemID)):
			normal_arrows_controller(inventory[String(slot)]["amount"])
	elif item_amount == null:
		inventory[String(slot)] = {"id": String(itemId), "amount": 1, "upgrades": item_upgrades}
		if (inventory[String(slot)]["id"] == String(normal_arrow_itemID)):
			normal_arrows_controller(inventory[String(slot)]["amount"])
	return slot
	#why doubled code from above??
	#print ("added item: " + str(itemId) + " : " + str(item_amount))

func inventory_removeItem(slot):
	var newAmount = inventory[String(slot)]["amount"] - 1
	#make arrows and torched droppable by 5 unless player has less than 5?
	if (newAmount < 1):
		inventory[String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		return 0
	inventory[String(slot)]["amount"] = newAmount
	if (inventory[String(slot)]["id"] == String(normal_arrow_itemID)):
		normal_arrows_controller(inventory[String(slot)]["amount"])
	return newAmount

func inventory_removeItem_all(slot):
	var newAmount = 0
	if (newAmount < 1):
		inventory[String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		return 0
	inventory[String(slot)]["amount"] = newAmount
	return newAmount

func inventory_moveItem(fromSlot, toSlot):
	var temp_ToSlotItem = inventory[String(toSlot)]
	inventory[String(toSlot)] = inventory[String(fromSlot)]
	inventory[String(fromSlot)] = temp_ToSlotItem

func normal_arrows_controller(normal_arrows_update_amount):
	var itemData = Global_ItemDatabase.get_item(String(normal_arrow_itemID))
	normal_arrow_counter = normal_arrows_update_amount

func arrows_check():
	for slot in range (0, inventory_maxSlots):
		if (inventory[String(slot)]["id"] == String(normal_arrow_itemID)):
			normal_arrow_counter = inventory[String(slot)]["amount"]
			return slot

#----Shop Setup----#
func shop_getEmptySlot():
	for slot in range(0, shop_inventory_maxSlots):
		if (shop_inventory[String(slot)]["id"] == "0"): 
			return int(slot)
	print ("Shops are full!")
	return -1

func shop_addItem(itemId, item_amount, item_upgrades):
	var itemData = Global_ItemDatabase.get_item(String(itemId))
	if (itemData == null): 
		return -1
	if (!itemData["stackable"]):
		var slot = shop_getEmptySlot()
		if (slot < 0): 
			return -1
		if item_amount != null:
			shop_inventory[String(slot)] = {"id": String(itemId), "amount": item_amount, "upgrades": item_upgrades}
		elif item_amount == null:
			shop_inventory[String(slot)] = {"id": String(itemId), "amount": 1, "upgrades": item_upgrades}
		return slot
	for slot in range (0, shop_inventory_maxSlots):
		if (shop_inventory[String(slot)]["id"] == String(itemId)):
			if item_amount != null:
				shop_inventory[String(slot)]["amount"] = int(shop_inventory[String(slot)]["amount"] + item_amount)
			elif item_amount == null:
				shop_inventory[String(slot)]["amount"] = int(shop_inventory[String(slot)]["amount"] + 1)
			return slot
	var slot = shop_getEmptySlot()
	if (slot < 0): 
		return -1
	if item_amount != null:
		shop_inventory[String(slot)] = {"id": String(itemId), "amount": item_amount, "upgrades": item_upgrades}
	elif item_amount == null:
		shop_inventory[String(slot)] = {"id": String(itemId), "amount": 1, "upgrades": item_upgrades}
	return slot
	#print ("shops have added item: " + str(itemId) + " : " + str(item_amount))

func shop_removeItem(slot):
	var newAmount = shop_inventory[String(slot)]["amount"] - 1
	if (newAmount < 1):
		shop_inventory[String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		return 0
	shop_inventory[String(slot)]["amount"] = newAmount
	return newAmount

func reset_shop_stock():
	for slot in range(0, shop_inventory_maxSlots):
		shop_removeItem_all(slot)

func shop_removeItem_all(slot):
	var newAmount = 0
	if (newAmount < 1):
		shop_inventory[String(slot)] = {"id": "0", "amount": 0, "upgrades": 0}
		return 0
	shop_inventory[String(slot)]["amount"] = newAmount
	return newAmount

func shop_moveItem(fromSlot, toSlot):
	var temp_ToSlotItem = shop_inventory[String(toSlot)]
	shop_inventory[String(toSlot)] = shop_inventory[String(fromSlot)]
	shop_inventory[String(fromSlot)] = temp_ToSlotItem

#general game data that should be kept between games regardless of player
func save_game_data():
	Global_DataParser.write_data(url_options_data, PlayerData.Game_Data)

func save_arena_scores():
	Global_DataParser.write_data(url_arena_scoreboard, PlayerData.arena_scores)


