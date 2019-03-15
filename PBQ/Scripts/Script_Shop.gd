extends Node
#itemList = player selling
onready var itemList = get_node("Control/TextureRect/NinePatchRect/ItemList")
#itemMenu = player selling
onready var itemMenu = get_node("Control/WindowDialog_ItemSell")
onready var itemMenu_TextureFrame_Icon = get_node("Control/WindowDialog_ItemSell/ItemSell_TextureFrame_Icon")
onready var itemMenu_RichTextLabel_ItemInfo = get_node("Control/WindowDialog_ItemSell/ItemSell_RichTextLabel_ItemInfo")
onready var itemMenu_Button_DropItem = get_node("Control/WindowDialog_ItemSell/ItemSell_Button_SellItem")
var activeItemSlot = -1
var dropItemSlot = -1

#itemMenu2 = shop inventory
onready var itemList2 = get_node("Control/TextureRect/NinePatchRect2/ItemList2")
onready var itemMenu2 = get_node("Control/WindowDialog_ItemBuy")
onready var itemMenu2_TextureFrame_Icon = get_node("Control/WindowDialog_ItemBuy/ItemBuy_TextureFrame_Icon")
onready var itemMenu2_RichTextLabel_ItemInfo = get_node("Control/WindowDialog_ItemBuy/ItemBuy_RichTextLabel_ItemInfo")
onready var itemMenu2_Button_DropItem = get_node("Control/WindowDialog_ItemBuy/ItemBuy_Button_BuyItem")
var activeItemSlot2 = -1
var dropItemSlot2 = -1

#for player inventory
onready var isDraggingItem = false
var draggedItemTexture
onready var draggedItem = get_node("Control/Sprite_DraggedItem")
onready var mouseButtonReleased = true
var draggedItemSlot = -1
onready var initial_mousePos = Vector2()
onready var cursor_insideItemList = false

#for shop inventory
var draggedItemSlot2 = -1
onready var cursor_insideItemList2 = false

#reused coding from the pause menu
var paused = false

onready var resume_button = get_node("Control/TextureRect/Button_Return_To_World")
onready var inventory_display = get_node("Control")

var currently_selected_weapon_id = 0
#change to item not weapon, as used for all, left for same reasons as inventory script

onready var type_of_item_selected
onready var amount_of_item_selected

var selling_price
var buying_price
var gold_coins

onready var not_enough_gold_label = get_node("Control/NotEnoughLabel")
onready var not_enough_gold_time = get_node("Control/NotEnoughLabel/NotEnoughTimer")

onready var coin_amount_label = get_node("Control/TextureRect/NinePatchRect/CoinsTexture/CoinsLabel")

var menu_is_open = false

func _ready():
	gold_coins = Global_Player.coin_counter
	# Initialize Item List = player inventory
	itemList.set_max_columns(10)
	itemList.set_fixed_icon_size(Vector2(50,50))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	itemList.set_allow_rmb_select(true)
	load_items()
	#initialize shop inventory next
	itemList2.set_max_columns(10)
	itemList2.set_fixed_icon_size(Vector2(50,50))
	itemList2.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList2.set_select_mode(ItemList.SELECT_SINGLE)
	itemList2.set_same_column_width(true)
	itemList2.set_allow_rmb_select(true)
	load_items_shop()

	set_process(false)
	set_process_input(true)

	#reused from pause menu
	unpause_inventory()
	get_tree().paused = false
	inventory_display.hide()
	print ("loading shops stuff")
	not_enough_gold_label.text = ""
	coin_amount_label.text = String(PlayerData.Player_Information.player_coins)

func _process(delta):
	if (isDraggingItem):
		draggedItem.global_position = get_viewport().get_mouse_position()

func pause_inventory():
	inventory_display.show()
	coin_amount_label.text = String(PlayerData.Player_Information.player_coins)
	paused = true
	get_tree().paused = true
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause_inventory():
	inventory_display.hide()
	itemMenu.hide()
	itemMenu2.hide()
	paused = false
	get_tree().paused = false
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# reused from pause menu

func _input(event):
	#adapted from pause menu
	if Input.is_action_just_pressed("inventorybutton"):
		if paused == false:
			pause_inventory()
		elif paused == true:
			unpause_inventory()
	
	if paused == true:
		if resume_button.is_pressed():
			unpause_inventory()
	
	if (event is InputEventMouseButton):
		if menu_is_open == false:
			if (event.is_action_pressed("left_mouse")):
				mouseButtonReleased = false
				initial_mousePos = get_viewport().get_mouse_position()
			if (event.is_action_released("left_mouse")):
				if (cursor_insideItemList):
					move_item()
					end_drag_item()
				elif (cursor_insideItemList2):
					move_item_shop()
					end_drag_item_shop()
	
	if (event is InputEventMouseMotion):
		#player inventory
		if (cursor_insideItemList):
			activeItemSlot = itemList.get_item_at_position(itemList.get_local_mouse_position(),true)
			if (activeItemSlot >= 0):
				itemList.select(activeItemSlot, true)
				if (isDraggingItem or mouseButtonReleased):
					return
				if (!itemList.is_item_selectable(activeItemSlot)): 
					end_drag_item()
				if (initial_mousePos.distance_to(get_viewport().get_mouse_position()) > 0.0): 
					begin_drag_item(activeItemSlot)
		else:
			activeItemSlot = -1
		#shop inventory
		if (cursor_insideItemList2):
			activeItemSlot2 = itemList2.get_item_at_position(itemList2.get_local_mouse_position(),true)
			if (activeItemSlot2 >= 0):
				itemList2.select(activeItemSlot2, true)
				if (isDraggingItem or mouseButtonReleased):
					return
				if (!itemList2.is_item_selectable(activeItemSlot2)): 
					end_drag_item_shop()
				if (initial_mousePos.distance_to(get_viewport().get_mouse_position()) > 0.0): 
					begin_drag_item_shop(activeItemSlot2)
		else:
			activeItemSlot2 = -1

func load_items():
	itemList.clear()
	for slot in range(0, Global_Player.inventory_maxSlots):
		itemList.add_item("", null, false)
		update_slot(slot)

func load_items_shop():
	itemList2.clear()
	for slot in range(0, Global_Player.shop_inventory_maxSlots):
		itemList2.add_item("", null, false)
		update_slot_shop(slot)

func update_slot(slot):
	var inventoryItem = Global_Player.inventory[String(slot)]
	var itemMetaData = Global_ItemDatabase.get_item(inventoryItem["id"])
	var icon = ResourceLoader.load(itemMetaData["icon"])
	var amount = int(inventoryItem["amount"])
	
	itemMetaData["amount"] = amount
	if (!itemMetaData["stackable"]): 
		amount = " "
	itemList.set_item_text(slot, String(amount))
	itemList.set_item_icon(slot, icon)
	itemList.set_item_selectable(slot, int(inventoryItem["id"]) > 0)
	itemList.set_item_metadata(slot, itemMetaData)
#	itemList.set_item_tooltip(slot, itemMetaData["name"])
	itemList.set_item_tooltip_enabled(slot, int(inventoryItem["id"]) > 0)

func update_slot_shop(slot):
	var inventoryItemshop = Global_Player.shop_inventory[String(slot)]
	var itemMetaDatashop = Global_ItemDatabase.get_item(inventoryItemshop["id"])
	var iconshop = ResourceLoader.load(itemMetaDatashop["icon"])
	var amountshop = int(inventoryItemshop["amount"])

	itemMetaDatashop["amount"] = amountshop
	if (!itemMetaDatashop["stackable"]): 
		amountshop = " "
	itemList2.set_item_text(slot, String(amountshop))
	itemList2.set_item_icon(slot, iconshop)
	itemList2.set_item_selectable(slot, int(inventoryItemshop["id"]) > 0)
	itemList2.set_item_metadata(slot, itemMetaDatashop)
#	itemList2.set_item_tooltip(slot, itemMetaData["name"])
	itemList2.set_item_tooltip_enabled(slot, int(inventoryItemshop["id"]) > 0)

func _on_pickup_acquired(itemID, itemAmount):
	#adapted from add button pressed code
	var affectedSlot = Global_Player.inventory_addItem(itemID, itemAmount)
	if (affectedSlot >= 0): 
		update_slot(affectedSlot)

#player side
func _on_ItemList_item_rmb_selected(index, atpos):
	if (isDraggingItem):
		return

	dropItemSlot = index

	var itemData = itemList.get_item_metadata(index)
	if (int(itemData["id"])) < 1: return
	var strItemInfo = ""

	_change_currently_selected_item_id(int(itemData["id"]))
	type_of_item_selected = itemData["type"]
	amount_of_item_selected = itemData["amount"]
	selling_price = itemData["sell_price"]
	#print ("current item ID: " + str(itemData["id"]) + ". Type: " + str(itemData["type"]))

	itemMenu.set_position(get_viewport().get_mouse_position())

	#itemMenu.set_title(itemData["name"])
	itemMenu_TextureFrame_Icon.set_texture(itemList.get_item_icon(index))

	strItemInfo = "Name: [color=#00aedb] " + itemData["name"] + "[/color]\n"
	strItemInfo = strItemInfo + "Type: [color=#f37735] " + itemData["type"] + "[/color]\n"
	if itemData["type"] == "Weapon" or itemData["type"] == "Ammunition":
		strItemInfo = strItemInfo + "Damage: [color=#f37735] " + String(itemData["damage"]) + "[/color]\n"
	elif itemData["type"] == "Armour" or itemData["type"] == "Helmet" or itemData["type"] == "Shield":
		strItemInfo = strItemInfo + "Defence: [color=#00aedb] " + String(itemData["armour"]) + "[/color]\n"
	elif itemData["type"] == "Consumable":
		strItemInfo = strItemInfo + "Gain: [color=#00aedb] " + String(itemData["gain"]) + "[/color]\n"

	strItemInfo = strItemInfo + "Weight: [color=#00b159] " + String(itemData["weight"]) + "[/color]\n"
	strItemInfo = strItemInfo + "Sell Price: [color=#ffc425] " + String(itemData["sell_price"]) + "[/color] gold\n"
	strItemInfo = strItemInfo + "\n[color=#b3cde0]" + itemData["description"] + "[/color]"

	itemMenu_RichTextLabel_ItemInfo.set_bbcode(strItemInfo)
	itemMenu_Button_DropItem.set_text("(" + String(itemData["amount"]) + ") Sell" )
	activeItemSlot = index
	itemMenu.show()
	menu_is_open = true

#shop side
func _on_ItemList2_item_rmb_selected(index2, at_position):
	if (isDraggingItem):
		return

	dropItemSlot2 = index2

	var itemData2 = itemList2.get_item_metadata(index2)
	if (int(itemData2["id"])) < 1: return
	var strItemInfo2 = ""

	_change_currently_selected_item_id(int(itemData2["id"]))
	type_of_item_selected = itemData2["type"]
	amount_of_item_selected = itemData2["amount"]
	buying_price = itemData2["buy_price"]
	#print ("current item ID: " + str(itemData["id"]) + ". Type: " + str(itemData["type"]))

	itemMenu2.set_position(get_viewport().get_mouse_position())

	#itemMenu2.set_title(itemData2["name"])
	itemMenu2_TextureFrame_Icon.set_texture(itemList2.get_item_icon(index2))

	strItemInfo2 = "Name: [color=#00aedb] " + itemData2["name"] + "[/color]\n"
	strItemInfo2 = strItemInfo2 + "Type: [color=#f37735] " + itemData2["type"] + "[/color]\n"
	if itemData2["type"] == "Weapon" or itemData2["type"] == "Ammunition":
		strItemInfo2 = strItemInfo2 + "Damage: [color=#f37735] " + String(itemData2["damage"]) + "[/color]\n"
	elif itemData2["type"] == "Armour" or itemData2["type"] == "Helmet" or itemData2["type"] == "Shield":
		strItemInfo2 = strItemInfo2 + "Defence: [color=#00aedb] " + String(itemData2["armour"]) + "[/color]\n"
	elif itemData2["type"] == "Consumable":
		strItemInfo2 = strItemInfo2 + "Gain: [color=#00aedb] " + String(itemData2["gain"]) + "[/color]\n"

	strItemInfo2 = strItemInfo2 + "Weight: [color=#00b159] " + String(itemData2["weight"]) + "[/color]\n"
	strItemInfo2 = strItemInfo2 + "Buy Price: [color=#ffc425] " + String(itemData2["buy_price"]) + "[/color] gold\n"
	strItemInfo2 = strItemInfo2 + "\n[color=#b3cde0]" + itemData2["description"] + "[/color]"

	itemMenu2_RichTextLabel_ItemInfo.set_bbcode(strItemInfo2)
	itemMenu2_Button_DropItem.set_text("(" + String(itemData2["amount"]) + ") Buy" )
	activeItemSlot2 = index2
	#itemMenu2.popup()
	itemMenu2.show()
	menu_is_open = true

#player side
func begin_drag_item(index):
	if (isDraggingItem): 
		return
	if (index < 0): 
		return

	set_process(true)
	draggedItem.texture = itemList.get_item_icon(index)
	draggedItem.show()

	itemList.set_item_text(index, " ")
	itemList.set_item_icon(index, ResourceLoader.load(Global_ItemDatabase.get_item(0)["icon"]))

	draggedItemSlot = index
	isDraggingItem = true
	mouseButtonReleased = false
	draggedItem.global_translate(get_viewport().get_mouse_position())

#shop side
func begin_drag_item_shop(index2):
	if (isDraggingItem): 
		return
	if (index2 < 0): 
		return

	set_process(true)
	draggedItem.texture = itemList2.get_item_icon(index2)
	draggedItem.show()

	itemList2.set_item_text(index2, " ")
	itemList2.set_item_icon(index2, ResourceLoader.load(Global_ItemDatabase.get_item(0)["icon"]))

	draggedItemSlot2 = index2
	isDraggingItem = true
	mouseButtonReleased = false
	draggedItem.global_translate(get_viewport().get_mouse_position())

#player side
func end_drag_item():
	set_process(false)
	draggedItemSlot = -1
	draggedItem.hide()
	mouseButtonReleased = true
	isDraggingItem = false
	activeItemSlot = -1
	return

#shop side
func end_drag_item_shop():
	set_process(false)
	draggedItemSlot2 = -1
	draggedItem.hide()
	mouseButtonReleased = true
	isDraggingItem = false
	activeItemSlot2 = -1
	return

#player side
func move_item():
	if (draggedItemSlot < 0): 
		return
	if (activeItemSlot == draggedItemSlot or activeItemSlot < 0):
		update_slot(draggedItemSlot)
		return
	Global_Player.inventory_moveItem(draggedItemSlot, activeItemSlot)
	update_slot(draggedItemSlot)
	update_slot(activeItemSlot)

#shop side
func move_item_shop():
	if (draggedItemSlot2 < 0): 
		return
	if (activeItemSlot2 == draggedItemSlot2 or activeItemSlot2 < 0):
		update_slot_shop(draggedItemSlot2)
		return
	Global_Player.shop_moveItem(draggedItemSlot2, activeItemSlot2)
	update_slot_shop(draggedItemSlot2)
	update_slot_shop(activeItemSlot2)

#player side
func _on_ItemList_mouse_entered():
	cursor_insideItemList = true;

func _on_ItemList_mouse_exited():
	cursor_insideItemList = false;

#shop side
func _on_ItemList2_mouse_entered():
	cursor_insideItemList2 = true;

func _on_ItemList2_mouse_exited():
	cursor_insideItemList2 = false;

func _change_currently_selected_item_id(id_to_change_to):
	currently_selected_weapon_id = id_to_change_to

func _on_Button_Return_To_World_pressed():
	unpause_inventory()

#player side
func _on_ItemSell_Button_SellItem_pressed():
	var newAmount = Global_Player.inventory_removeItem(dropItemSlot)
	if (newAmount < 1):
		itemMenu.hide()
	else:
		itemMenu_Button_DropItem.set_text("(" + String(newAmount) + ") Sell")
		amount_of_item_selected = newAmount
	update_slot(dropItemSlot)
	PlayerData.Player_Information.player_coins += selling_price
	coin_amount_label.text = String(PlayerData.Player_Information.player_coins)
	#VV can be used to move items across to the shop once sold
	#not needed in this case yet, for simplicity
	#Global_Player.shop_addItem(currently_selected_weapon_id, 1)
	#reload the player inventory slots to update the player inventory
	load_items()
	#reload the shop inventory if desired, not used here, as set on setup
	#load_items_shop()

#shop side
func _on_ItemBuy_Button_BuyItem_pressed():
	gold_coins = PlayerData.Player_Information.player_coins
	if gold_coins >= buying_price:
		_on_pickup_acquired(currently_selected_weapon_id, 1)
		PlayerData.Player_Information.player_coins -= buying_price
		load_items()
		#load_items_shop() #if using dynamic inventory for shop
		not_enough_gold_label.text = "Bought Item"
		not_enough_gold_time.start()
	elif gold_coins < buying_price:
		not_enough_gold_label.text = "Not Enough Gold"
		not_enough_gold_time.start()
	coin_amount_label.text = String(PlayerData.Player_Information.player_coins)

func _on_NotEnoughTimer_timeout():
	not_enough_gold_label.text = ""

func _on_Close_Button_ItemSell_pressed():
	itemMenu.hide()
	menu_is_open = false

func _on_Close_Button_ItemBuy_pressed():
	itemMenu2.hide()
	menu_is_open = false
