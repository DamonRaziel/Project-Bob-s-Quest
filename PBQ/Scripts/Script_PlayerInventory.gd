extends Node
#adapted from the inventory demo that should be shown in the credits section

onready var itemList = get_node("Panel/ItemList")
# WindowDialog_AddItemWindow Variables.
onready var addItemWindow = get_node("Panel/WindowDialog_AddItemWindow")
onready var addItemWindow_SpinBox_ItemId = get_node("Panel/WindowDialog_AddItemWindow/AddItemWindow_SpinBox_ItemID")
# WindowDialog_ItemMenu Variables.
onready var itemMenu = get_node("Panel/WindowDialog_ItemMenu")
onready var itemMenu_TextureFrame_Icon = get_node("Panel/WindowDialog_ItemMenu/ItemMenu_TextureFrame_Icon")
onready var itemMenu_RichTextLabel_ItemInfo = get_node("Panel/WindowDialog_ItemMenu/ItemMenu_RichTextLabel_ItemInfo")
onready var itemMenu_Button_DropItem = get_node("Panel/WindowDialog_ItemMenu/ItemMenu_Button_DropItem")
var activeItemSlot = -1
var dropItemSlot = -1

onready var isDraggingItem = false
var draggedItemTexture
onready var draggedItem = get_node("Panel/Sprite_DraggedItem")
onready var mouseButtonReleased = true
var draggedItemSlot = -1
onready var initial_mousePos = Vector2()
onready var cursor_insideItemList = false

#reused coding from the pause menu
var paused = false

onready var resume_button = get_node("Panel/ResumeButton")
onready var inventory_display = get_node("Panel")

onready var weapon_slot_selection_window = get_node("Panel/WindowDialog_ItemMenu/ItemMenu_Button_EquipItem/WindowDialog_WeaponSlotSelection")
onready var item_slot_selection_window = get_node("Panel/WindowDialog_ItemMenu/ItemMenu_Button_EquipItem/WindowDialog_ItemSlotSelection")

#vars for equiped weapons items, etc
onready var weapon_slot1_icon = get_node("Panel/EquipmentSlotsHolder/WeaponSlot1/WeaponSlot1Texture")
onready var weapon_slot2_icon = get_node("Panel/EquipmentSlotsHolder/WeaponSlot2/WeaponSlot2Texture")
onready var weapon_slot3_icon = get_node("Panel/EquipmentSlotsHolder/WeaponSlot3/WeaponSlot3Texture")

onready var armour_slot_icon = get_node("Panel/EquipmentSlotsHolder/ArmourSlot/ArmourSlotTexture")
onready var shield_slot_icon = get_node("Panel/EquipmentSlotsHolder/ShieldSlot/ShieldSlotTexture")

onready var item_slot1_icon = get_node("Panel/EquipmentSlotsHolder2/ItemSlot1/ItemTextureSlot1")
onready var item_slot2_icon = get_node("Panel/EquipmentSlotsHolder2/ItemSlot2/ItemTextureSlot2")
onready var item_slot3_icon = get_node("Panel/EquipmentSlotsHolder2/ItemSlot3/ItemTextureSlot3")
onready var item_slot4_icon = get_node("Panel/EquipmentSlotsHolder2/ItemSlot4/ItemTextureSlot4")
onready var item_slot5_icon = get_node("Panel/EquipmentSlotsHolder2/ItemSlot5/ItemTextureSlot5")
onready var item_slot6_icon = get_node("Panel/EquipmentSlotsHolder2/ItemSlot6/ItemTextureSlot6")

onready var item_slot1_label= get_node("Panel/EquipmentSlotsHolder2/ItemSlot1/ItemTextureSlot1/SlotLabel1")
onready var item_slot2_label= get_node("Panel/EquipmentSlotsHolder2/ItemSlot2/ItemTextureSlot2/SlotLabel2")
onready var item_slot3_label= get_node("Panel/EquipmentSlotsHolder2/ItemSlot3/ItemTextureSlot3/SlotLabel3")
onready var item_slot4_label= get_node("Panel/EquipmentSlotsHolder2/ItemSlot4/ItemTextureSlot4/SlotLabel4")
onready var item_slot5_label= get_node("Panel/EquipmentSlotsHolder2/ItemSlot5/ItemTextureSlot5/SlotLabel5")
onready var item_slot6_label= get_node("Panel/EquipmentSlotsHolder2/ItemSlot6/ItemTextureSlot6/SlotLabel6")

var currently_selected_weapon_id = 0
#change to item not weapon, as used for all
#is still weapon, for ease of use

onready var weaponslot1label = get_node("Panel/EquipmentSlotsHolder/WeaponSlot1/WeaponSlot1Texture/Label")
onready var type_of_item_selected
onready var amount_of_item_selected

onready var coin_amount_label = get_node("Panel/EquipmentSlotsHolder/CoinsTexture/CoinsLabel")

onready var slots_holder = get_node("SlotsPanel")
onready var slots_shower = get_node("SlotsPanel/SlotsBGShow")

onready var slot_icon1 = get_node("SlotsPanel/SlotIcon1")
onready var slot_icon2 = get_node("SlotsPanel/SlotIcon2")
onready var slot_icon3 = get_node("SlotsPanel/SlotIcon3")
onready var slot_icon4 = get_node("SlotsPanel/SlotIcon4")
onready var slot_icon5 = get_node("SlotsPanel/SlotIcon5")
onready var slot_icon6 = get_node("SlotsPanel/SlotIcon6")
onready var slot_icon7 = get_node("SlotsPanel/SlotIcon7")
onready var slot_icon8 = get_node("SlotsPanel/SlotIcon8")
onready var slot_icon9 = get_node("SlotsPanel/SlotIcon9")

onready var item_dropper_rotator = get_node("DropperRotator")
onready var item_dropper = get_node("DropperRotator/Dropper")

func _ready():
	# Initialize Item List
	itemList.set_max_columns(10)
	itemList.set_fixed_icon_size(Vector2(50,50))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	itemList.set_allow_rmb_select(true)
	
	load_items()
	
	set_process(false)
	set_process_input(true)
	
	#reused from pause menu
	unpause_inventory()
	print ("loading inventory")
	coin_amount_label.text = String(PlayerData.Player_Information.player_coins)

func _process(delta):
	if (isDraggingItem):
		draggedItem.global_position = get_viewport().get_mouse_position()

func pause_inventory():
	inventory_display.show()
	coin_amount_label.text = String(PlayerData.Player_Information.player_coins)
	paused = true
	get_tree().paused = true
	#show the mouse cursor
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause_inventory():
	inventory_display.hide()
	weapon_slot_selection_window.hide()
	item_slot_selection_window.hide()
	itemMenu.hide()
	paused = false
	get_tree().paused = false
	#hide the mouse cursor
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
		if (event.is_action_pressed("left_mouse")):
			mouseButtonReleased = false
			initial_mousePos = get_viewport().get_mouse_position()
		if (event.is_action_released("left_mouse")):
			move_item()
			end_drag_item()
			
	if (event is InputEventMouseMotion):
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
	
	if Input.is_action_just_pressed("hide"):
		if (slots_holder.rect_position.y == 0):
			slots_holder.rect_position.y = -90
		elif (slots_holder.rect_position.y == -90):
			slots_holder.rect_position.y = 0

func load_items():
	itemList.clear()
	for slot in range(0, Global_Player.inventory_maxSlots):
		itemList.add_item("", null, false)
		update_slot(slot)
	
	#weapon slots
	if Global_Player.inventory_equiped_items.inventory_weapons1 != -1:
		var weapon_in_slot1 = Global_Player.inventory_equiped_items.inventory_weapons1
		_assign_weapon_slot_1(weapon_in_slot1)
	if Global_Player.inventory_equiped_items.inventory_weapons2 != -1:
		var weapon_in_slot2 = Global_Player.inventory_equiped_items.inventory_weapons2
		_assign_weapon_slot_2(weapon_in_slot2)
	if Global_Player.inventory_equiped_items.inventory_weapons3 != -1:
		var weapon_in_slot3 = Global_Player.inventory_equiped_items.inventory_weapons3
		_assign_weapon_slot_3(weapon_in_slot3)
	
	#armour and shield slots
	if Global_Player.inventory_equiped_items.inventory_armour1 != -1:
		var armour_in_slot = Global_Player.inventory_equiped_items.inventory_armour1
		_assign_armour_slot(armour_in_slot)
	if Global_Player.inventory_equiped_items.inventory_shield1 != 1:
		var shield_in_slot = Global_Player.inventory_equiped_items.inventory_shield1
		_assign_shield_slot(shield_in_slot)
	
	#item slots
	if Global_Player.inventory_equiped_items.inventory_items1 != -1:
		var item_in_slot1 = Global_Player.inventory_equiped_items.inventory_items1
		var item_amount_in_slot1 = Global_Player.inventory_equiped_items.inventory_items1_amount
		_assign_item_slot_1(item_in_slot1, item_amount_in_slot1)
	if Global_Player.inventory_equiped_items.inventory_items2 != -1:
		var item_in_slot2 = Global_Player.inventory_equiped_items.inventory_items2
		var item_amount_in_slot2 = Global_Player.inventory_equiped_items.inventory_items2_amount
		_assign_item_slot_2(item_in_slot2, item_amount_in_slot2)
	if Global_Player.inventory_equiped_items.inventory_items3 != -1:
		var item_in_slot3 = Global_Player.inventory_equiped_items.inventory_items3
		var item_amount_in_slot3 = Global_Player.inventory_equiped_items.inventory_items3_amount
		_assign_item_slot_3(item_in_slot3, item_amount_in_slot3)
	if Global_Player.inventory_equiped_items.inventory_items4 != -1:
		var item_in_slot4 = Global_Player.inventory_equiped_items.inventory_items4
		var item_amount_in_slot4 = Global_Player.inventory_equiped_items.inventory_items4_amount
		_assign_item_slot_4(item_in_slot4, item_amount_in_slot4)
	if Global_Player.inventory_equiped_items.inventory_items5 != -1:
		var item_in_slot5 = Global_Player.inventory_equiped_items.inventory_items5
		var item_amount_in_slot5 = Global_Player.inventory_equiped_items.inventory_items5_amount
		_assign_item_slot_5(item_in_slot5, item_amount_in_slot5)
	if Global_Player.inventory_equiped_items.inventory_items6 != -1:
		var item_in_slot6 = Global_Player.inventory_equiped_items.inventory_items6
		var item_amount_in_slot6 = Global_Player.inventory_equiped_items.inventory_items6_amount
		_assign_item_slot_6(item_in_slot6, item_amount_in_slot6)

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
	itemList.set_item_tooltip(slot, itemMetaData["name"])
	itemList.set_item_tooltip_enabled(slot, int(inventoryItem["id"]) > 0)

func _on_Button_AddItem_pressed():
	addItemWindow.popup()
	#need to remove this once obselete, as additions
	#will be done by collisions with pickups
	#left in for others to play about with if they want

func _on_AddItemWindow_Button_Close_pressed():
	addItemWindow.hide()
	#need to replace this section once it becomes obselete, as above

func _on_AddItemWindow_Button_AddItem_pressed():
	#in next line, change the additwmwindowspinner data sent to the id number of the item itself, sent from the pickups
	#have pickups sent their data to the inventory script, not the player script??
	#need to change to from collisions with pickups, instead of button press
	var affectedSlot = Global_Player.inventory_addItem(addItemWindow_SpinBox_ItemId.get_value(), 1)
	if (affectedSlot >= 0): 
		update_slot(affectedSlot)

func _on_pickup_acquired(itemID, itemAmount):
	#adapted from add button pressed code
	var affectedSlot = Global_Player.inventory_addItem(itemID, itemAmount)
	if (affectedSlot >= 0): 
		update_slot(affectedSlot)

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
	#print ("current item ID: " + str(itemData["id"]) + ". Type: " + str(itemData["type"]))
	
	itemMenu.set_position(get_viewport().get_mouse_position())
	
	#itemMenu.set_title(itemData["name"]) # got rid of, as changed from windowdialogbox
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
	itemMenu_Button_DropItem.set_text("(" + String(itemData["amount"]) + ") Drop" )
	activeItemSlot = index
	itemMenu.show()

func _on_ItemMenu_Button_DropItem_pressed():
	var newAmount = Global_Player.inventory_removeItem(dropItemSlot)
	if (newAmount < 1):
		itemMenu.hide()
	else:
		itemMenu_Button_DropItem.set_text("(" + String(newAmount) + ") Drop")
		amount_of_item_selected = newAmount
	item_dropper.add_item_drop(currently_selected_weapon_id)
	update_slot(dropItemSlot)

func _on_ItemMenu_Button_DropItem_pressed_fullamount(amount_to_drop): #not actually a button, but copied code and adapted
	var newAmount = Global_Player.inventory_removeItem_all(dropItemSlot)
	if (newAmount < 1):
		itemMenu.hide()
	else:
		itemMenu_Button_DropItem.set_text("(" + String(newAmount) + ") Drop")
	update_slot(dropItemSlot)

func _on_ItemMenu_EquipedItem(): #for weapons and equipment, not items, as items are not "equiped" on the character
	var newAmount = Global_Player.inventory_removeItem(dropItemSlot)
	if (newAmount < 1):
		itemMenu.hide()
	else:
		itemMenu_Button_DropItem.set_text("(" + String(newAmount) + ") Drop")
		amount_of_item_selected = newAmount
	update_slot(dropItemSlot)

func _on_Button_Save_pressed(): #original button for saving inventory, basis of save files
	Global_Player.save_data()

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

func end_drag_item():
	set_process(false)
	draggedItemSlot = -1
	draggedItem.hide()
	mouseButtonReleased = true
	isDraggingItem = false
	activeItemSlot = -1
	return

func move_item():
	if (draggedItemSlot < 0): 
		return
	if (activeItemSlot == draggedItemSlot or activeItemSlot < 0):
		update_slot(draggedItemSlot)
		return
	Global_Player.inventory_moveItem(draggedItemSlot, activeItemSlot)
	update_slot(draggedItemSlot)
	update_slot(activeItemSlot)

func _on_ItemList_mouse_entered():
	cursor_insideItemList = true;

func _on_ItemList_mouse_exited():
	cursor_insideItemList = false;

#slot selection section begin#
func _change_currently_selected_item_id(id_to_change_to):
	currently_selected_weapon_id = id_to_change_to
	#can be moved up to rmb section??

func _on_ItemMenu_Button_EquipItem_pressed():
	if type_of_item_selected == "Weapon":
		weapon_slot_selection_window.show()
		weapon_slot_selection_window.set_position(get_viewport().get_mouse_position())
	elif type_of_item_selected == "Consumable" or type_of_item_selected == "Item":
		item_slot_selection_window.show()
		item_slot_selection_window.set_position(get_viewport().get_mouse_position())
	elif type_of_item_selected == "Armour":
		_on_ArmourSlotUequipButton_pressed()
		_assign_armour_slot(currently_selected_weapon_id)
		_on_ItemMenu_EquipedItem()
	elif type_of_item_selected == "Shield":
		_on_ShieldSlotUequipButton_pressed()
		_assign_shield_slot(currently_selected_weapon_id)
		_on_ItemMenu_EquipedItem()
#slot selection section end#

#slot assignment section begin#
func _assign_weapon_slot_1(weapon_to_assign):
	Global_Player.inventory_equiped_items.inventory_weapons1 = weapon_to_assign
	#print ("weapon in slot 1 is " + str(weapon_to_assign))
	weapon_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_weapons1 != -1:
		weapon_slot1_icon.show()
		slot_icon1.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_weapons1
		weapon_slot1_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon1.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		weapon_slot1_icon.hide()
		slot_icon1.hide()

func _assign_weapon_slot_2(weapon_to_assign):
	Global_Player.inventory_equiped_items.inventory_weapons2 = weapon_to_assign
	#print ("weapon in slot 2 is " + str(weapon_to_assign))
	weapon_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_weapons2 != -1:
		weapon_slot2_icon.show()
		slot_icon2.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_weapons2
		weapon_slot2_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon2.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		weapon_slot2_icon.hide()
		slot_icon2.hide()

func _assign_weapon_slot_3(weapon_to_assign):
	Global_Player.inventory_equiped_items.inventory_weapons3 = weapon_to_assign
	#print ("weapon in slot 3 is " + str(weapon_to_assign))
	weapon_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_weapons3 != -1:
		weapon_slot3_icon.show()
		slot_icon3.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_weapons3
		weapon_slot3_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon3.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		weapon_slot3_icon.hide()
		slot_icon3.hide()

func update_slot1_amount():
	item_slot1_label.text = str(Global_Player.inventory_equiped_items.inventory_items1_amount)

func update_slot2_amount():
	item_slot2_label.text = str(Global_Player.inventory_equiped_items.inventory_items2_amount)

func update_slot3_amount():
	item_slot3_label.text = str(Global_Player.inventory_equiped_items.inventory_items3_amount)

func update_slot4_amount():
	item_slot4_label.text = str(Global_Player.inventory_equiped_items.inventory_items4_amount)

func update_slot5_amount():
	item_slot5_label.text = str(Global_Player.inventory_equiped_items.inventory_items5_amount)

func update_slot6_amount():
	item_slot6_label.text = str(Global_Player.inventory_equiped_items.inventory_items6_amount)
	print(Global_Player.inventory_equiped_items.inventory_items6_amount)

func _assign_item_slot_1(item_to_assign, amount_to_assign):
	Global_Player.inventory_equiped_items.inventory_items1 = item_to_assign
	Global_Player.inventory_equiped_items.inventory_items1_amount = amount_to_assign
	update_slot1_amount()
	#print ("item in slot 1 is " + str(item_to_assign))
	item_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_items1  != -1:
		item_slot1_icon.show()
		slot_icon4.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_items1 
		item_slot1_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon4.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		item_slot1_icon.hide()
		slot_icon4.hide()

func _assign_item_slot_2(item_to_assign, amount_to_assign):
	Global_Player.inventory_equiped_items.inventory_items2 = item_to_assign
	Global_Player.inventory_equiped_items.inventory_items2_amount = amount_to_assign
	update_slot2_amount()
	#print ("item in slot 2 is " + str(item_to_assign))
	item_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_items2  != -1:
		item_slot2_icon.show()
		slot_icon5.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_items2 
		item_slot2_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon5.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		item_slot2_icon.hide()
		slot_icon5.hide()

func _assign_item_slot_3(item_to_assign, amount_to_assign):
	Global_Player.inventory_equiped_items.inventory_items3 = item_to_assign
	Global_Player.inventory_equiped_items.inventory_items3_amount = amount_to_assign
	update_slot3_amount()
	#print ("item in slot 3 is " + str(item_to_assign))
	item_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_items3  != -1:
		item_slot3_icon.show()
		slot_icon6.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_items3 
		item_slot3_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon6.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		item_slot3_icon.hide()
		slot_icon6.hide()

func _assign_item_slot_4(item_to_assign, amount_to_assign):
	Global_Player.inventory_equiped_items.inventory_items4 = item_to_assign
	Global_Player.inventory_equiped_items.inventory_items4_amount = amount_to_assign
	update_slot4_amount()
	#print ("item in slot 4 is " + str(item_to_assign))
	item_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_items4  != -1:
		item_slot4_icon.show()
		slot_icon7.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_items4
		item_slot4_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon7.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		item_slot4_icon.hide()
		slot_icon7.hide()

func _assign_item_slot_5(item_to_assign, amount_to_assign):
	Global_Player.inventory_equiped_items.inventory_items5 = item_to_assign
	Global_Player.inventory_equiped_items.inventory_items5_amount = amount_to_assign
	update_slot5_amount()
	#print ("item in slot 5 is " + str(item_to_assign))
	item_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_items5  != -1:
		item_slot5_icon.show()
		slot_icon8.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_items5 
		item_slot5_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon8.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		item_slot5_icon.hide()
		slot_icon8.hide()

func _assign_item_slot_6(item_to_assign, amount_to_assign):
	Global_Player.inventory_equiped_items.inventory_items6 = item_to_assign
	Global_Player.inventory_equiped_items.inventory_items6_amount = amount_to_assign
	update_slot6_amount()
	#print ("item in slot 6 is " + str(item_to_assign))
	item_slot_selection_window.hide()
	if Global_Player.inventory_equiped_items.inventory_items6  != -1:
		item_slot6_icon.show()
		slot_icon9.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_items6 
		item_slot6_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
		slot_icon9.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		item_slot6_icon.hide()
		slot_icon9.hide()
#slot assignment section end#

#slot assignment buttons pressed section begin#
func _on_WeaponSlot1Button_pressed():
	_on_WeaponSlot1UnequipButton_pressed()
	_assign_weapon_slot_1(currently_selected_weapon_id)
	_on_ItemMenu_EquipedItem()

func _on_WeaponSlot2Button_pressed():
	_on_WeaponSlot2UnequipButton_pressed()
	_assign_weapon_slot_2(currently_selected_weapon_id)
	_on_ItemMenu_EquipedItem()

func _on_WeaponSlot3Button_pressed():
	_on_WeaponSlot3UnequipButton_pressed()
	_assign_weapon_slot_3(currently_selected_weapon_id)
	_on_ItemMenu_EquipedItem()

func _on_ItemSlot1Button_pressed():
	if Global_Player.inventory_equiped_items.inventory_items1 == currently_selected_weapon_id:
		var add_item_amount = Global_Player.inventory_equiped_items.inventory_items1_amount + amount_of_item_selected
		_on_ItemUnequipButtonSlot1_pressed()
		_assign_item_slot_1(currently_selected_weapon_id, add_item_amount)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
	else:
		_on_ItemUnequipButtonSlot1_pressed()
		_assign_item_slot_1(currently_selected_weapon_id, amount_of_item_selected)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)

func _on_ItemSlot2Button_pressed():
	if Global_Player.inventory_equiped_items.inventory_items2 == currently_selected_weapon_id:
		var add_item_amount = Global_Player.inventory_equiped_items.inventory_items2_amount + amount_of_item_selected
		_on_ItemUnequipButtonSlot2_pressed()
		_assign_item_slot_2(currently_selected_weapon_id, add_item_amount)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
	else:
		_on_ItemUnequipButtonSlot2_pressed()
		_assign_item_slot_2(currently_selected_weapon_id, amount_of_item_selected)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)

func _on_ItemSlot3Button_pressed():
	if Global_Player.inventory_equiped_items.inventory_items3 == currently_selected_weapon_id:
		var add_item_amount = Global_Player.inventory_equiped_items.inventory_items3_amount + amount_of_item_selected
		_on_ItemUnequipButtonSlot3_pressed()
		_assign_item_slot_3(currently_selected_weapon_id, add_item_amount)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
	else:
		_on_ItemUnequipButtonSlot3_pressed()
		_assign_item_slot_3(currently_selected_weapon_id, amount_of_item_selected)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)

func _on_ItemSlot4Button_pressed():
	if Global_Player.inventory_equiped_items.inventory_items4 == currently_selected_weapon_id:
		var add_item_amount = Global_Player.inventory_equiped_items.inventory_items4_amount + amount_of_item_selected
		_on_ItemUnequipButtonSlot4_pressed()
		_assign_item_slot_4(currently_selected_weapon_id, add_item_amount)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
	else:
		_on_ItemUnequipButtonSlot4_pressed()
		_assign_item_slot_4(currently_selected_weapon_id, amount_of_item_selected)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)

func _on_ItemSlot5Button_pressed():
	if Global_Player.inventory_equiped_items.inventory_items5 == currently_selected_weapon_id:
		var add_item_amount = Global_Player.inventory_equiped_items.inventory_items5_amount + amount_of_item_selected
		_on_ItemUnequipButtonSlot5_pressed()
		_assign_item_slot_5(currently_selected_weapon_id, add_item_amount)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
	else:
		_on_ItemUnequipButtonSlot5_pressed()
		_assign_item_slot_5(currently_selected_weapon_id, amount_of_item_selected)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)

func _on_ItemSlot6Button_pressed():
	if Global_Player.inventory_equiped_items.inventory_items6 == currently_selected_weapon_id:
		var add_item_amount = Global_Player.inventory_equiped_items.inventory_items6_amount + amount_of_item_selected
		_on_ItemUnequipButtonSlot6_pressed()
		_assign_item_slot_6(currently_selected_weapon_id, add_item_amount)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
	else:
		_on_ItemUnequipButtonSlot6_pressed()
		_assign_item_slot_6(currently_selected_weapon_id, amount_of_item_selected)
		_on_ItemMenu_Button_DropItem_pressed_fullamount(amount_of_item_selected)
#slot assignment buttons pressed section end#

#slot unassignment/unequip buttons pressed section begin#
func _on_WeaponSlot1UnequipButton_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_weapons1
	var itemID = globalItemID
	var itemAmount = 1
	#make so if inventory is full, drops item, if inventory has space, add to main area
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_weapon_slot_1(-1)

func _on_WeaponSlot2UnequipButton_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_weapons2
	var itemID = globalItemID
	var itemAmount = 1
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_weapon_slot_2(-1)

func _on_WeaponSlot3UnequipButton_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_weapons3
	var itemID = globalItemID
	var itemAmount = 1
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_weapon_slot_3(-1)

func _on_ItemUnequipButtonSlot1_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_items1
	var itemID = globalItemID
	var itemAmount = Global_Player.inventory_equiped_items.inventory_items1_amount
	#need to add amounts for items to ensure the correct amount gets returned
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_item_slot_1(-1, -1)

func _on_ItemUnequipButtonSlot2_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_items2
	var itemID = globalItemID
	var itemAmount = Global_Player.inventory_equiped_items.inventory_items2_amount
	#need to add amounts for items to ensure the correct amount gets returned
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_item_slot_2(-1, -1)

func _on_ItemUnequipButtonSlot3_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_items3
	var itemID = globalItemID
	var itemAmount = Global_Player.inventory_equiped_items.inventory_items3_amount
	#need to add amounts for items to ensure the correct amount gets returned
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_item_slot_3(-1, -1)

func _on_ItemUnequipButtonSlot4_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_items4
	var itemID = globalItemID
	var itemAmount = Global_Player.inventory_equiped_items.inventory_items4_amount
	#need to add amounts for items to ensure the correct amount gets returned
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_item_slot_4(-1, -1)

func _on_ItemUnequipButtonSlot5_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_items5
	var itemID = globalItemID
	var itemAmount = Global_Player.inventory_equiped_items.inventory_items5_amount
	#need to add amounts for items to ensure the correct amount gets returned
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_item_slot_5(-1, -1)

func _on_ItemUnequipButtonSlot6_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_items6
	var itemID = globalItemID
	var itemAmount = Global_Player.inventory_equiped_items.inventory_items6_amount
	#need to add amounts for items to ensure the correct amount gets returned
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_item_slot_6(-1, -1)
#slot unassignment/unequip buttons pressed section end#

func _assign_armour_slot(armour_to_assign):
	Global_Player.inventory_equiped_items.inventory_armour1 = armour_to_assign
	PlayerData.Player_Information.player_current_armour_number = Global_Player.inventory_equiped_items.inventory_armour1
	#print ("armour number: " + str(Global_Player.inventory_equiped_items.inventory_armour1))
	if Global_Player.inventory_equiped_items.inventory_armour1 != -1:
		armour_slot_icon.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_armour1
		armour_slot_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		armour_slot_icon.hide()

func _on_ArmourSlotUequipButton_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_armour1
	var itemID = globalItemID
	var itemAmount = 1
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_armour_slot(-1)

func _assign_shield_slot(shield_to_assign):
	Global_Player.inventory_equiped_items.inventory_shield1 = shield_to_assign
	PlayerData.Player_Information.player_current_shield_number = Global_Player.inventory_equiped_items.inventory_shield1
	if Global_Player.inventory_equiped_items.inventory_shield1 != -1:
		shield_slot_icon.show()
		var slot_image_getter = Global_Player.inventory_equiped_items.inventory_shield1
		shield_slot_icon.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["icon"]))
	else:
		shield_slot_icon.hide()

func _on_ShieldSlotUequipButton_pressed():
	var globalItemID = Global_Player.inventory_equiped_items.inventory_shield1
	var itemID = globalItemID
	var itemAmount = 1
	Global_Player.check_if_inventory_is_full()
	if PlayerData.Player_Information.player_inventory_is_full == false:
		_on_pickup_acquired(itemID, itemAmount)
	elif PlayerData.Player_Information.player_inventory_is_full == true:
		item_dropper.add_item_drop(itemID)
	_assign_shield_slot(-1)

func _on_Close_Button_pressed():
	itemMenu.hide()
	weapon_slot_selection_window.hide()
	item_slot_selection_window.hide()
