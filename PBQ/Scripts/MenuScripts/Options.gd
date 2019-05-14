extends Control

var m_vol
var cur_show
var slots_show

onready var master_volume_label = get_node("OptionsHolder/MasterVolume/MVolLabel")
onready var master_volume_slider = get_node("OptionsHolder/MasterVolume/MVolSlider")

onready var music_volume_label = get_node("OptionsHolder/MusicOnOff/MusicVolLabel")
onready var music_volume_slider = get_node("OptionsHolder/MusicOnOff/MusicVolSlider")

onready var sfx_volume_label = get_node("OptionsHolder/SoundsOnOff/SFXVolLabel")
onready var sfx_volume_slider = get_node("OptionsHolder/SoundsOnOff/SFXVolSlider")

onready var aiming_cursor_slider = get_node("OptionsHolder/ShowAimingCursor/CurSlider")
onready var slots_hint_show_slider = get_node("OptionsHolder/SlotsHideHint/SlotsSlider")

onready var look_sensitivity_label = get_node("OptionsHolder/LookSensitivity/LookSenLabel")
onready var look_sensitivity_slider = get_node("OptionsHolder/LookSensitivity/LookSenSlider")

func _ready():
	master_volume_slider.value = PlayerData.Options_Data.master_volume
	music_volume_slider.value = PlayerData.Options_Data.music_volume
	sfx_volume_slider.value = PlayerData.Options_Data.sfx_volume
	aiming_cursor_slider.value = PlayerData.Options_Data.aiming_cursor_show
	slots_hint_show_slider.value = PlayerData.Options_Data.slots_hint_show
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerData.Options_Data.master_volume)#master_volume_slider.value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("MusicBus"), PlayerData.Options_Data.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFXBus"), PlayerData.Options_Data.sfx_volume)
	look_sensitivity_slider.value = PlayerData.Options_Data.look_sensitivity

func _process(delta):
	PlayerData.Options_Data.master_volume = master_volume_slider.value
	PlayerData.Options_Data.music_volume = music_volume_slider.value
	PlayerData.Options_Data.sfx_volume = sfx_volume_slider.value
	master_volume_label.text = str(PlayerData.Options_Data.master_volume)
	music_volume_label.text = str(PlayerData.Options_Data.music_volume)
	sfx_volume_label.text = str(PlayerData.Options_Data.sfx_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerData.Options_Data.master_volume)#master_volume_slider.value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("MusicBus"), PlayerData.Options_Data.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFXBus"), PlayerData.Options_Data.sfx_volume)
	PlayerData.Options_Data.aiming_cursor_show = aiming_cursor_slider.value
	PlayerData.Options_Data.slots_hint_show = slots_hint_show_slider.value
	PlayerData.Options_Data.look_sensitivity = look_sensitivity_slider.value
	look_sensitivity_label.text = str(PlayerData.Options_Data.look_sensitivity)

func _on_SaveOptions_pressed():
	Global_Player.save_options_data()
	get_parent().get_parent().move_menu_right = true
	#saves changes and returns to other menus

func _on_CancelOptions_pressed():
	#doesnt save changes and returns to other menus
	get_parent().get_parent().move_menu_right = true

#languages and difficulties not yet implemented
func _on_EnglishButton_pressed():
	PlayerData.Options_Data.language = "English"

func _on_SpanishButton_pressed():
	PlayerData.Options_Data.language = "Spanish"

func _on_FilipinoButton_pressed():
	PlayerData.Options_Data.language = "Filipino"

func _on_NormalButton_pressed():
	PlayerData.Options_Data.difficulty = 0

func _on_HardButton_pressed():
	PlayerData.Options_Data.difficulty = 1

func _on_VHardButton_pressed():
	PlayerData.Options_Data.difficulty = 2
