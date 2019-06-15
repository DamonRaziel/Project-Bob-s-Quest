extends Control

onready var ma_vol_label = $OptionsHolder/MasterVolume
onready var so_vol_label = $OptionsHolder/SoundsOnOff
onready var mu_vol_label = $OptionsHolder/MusicOnOff
onready var cur_show_label = $OptionsHolder/ShowAimingCursor
onready var slots_show_label = $OptionsHolder/SlotsHideHint
onready var sens_label = $OptionsHolder/LookSensitivity
onready var lang_label = $OptionsHolder/Language
onready var diff_label = $OptionsHolder/Difficulty

onready var easy_button = $OptionsHolder/Difficulty/NormalButton
onready var normal_button = $OptionsHolder/Difficulty/HardButton
onready var hard_buttonn = $OptionsHolder/Difficulty/VHardButton
onready var save_button = $SaveOptions
onready var cancel_button = $CancelOptions

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
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerData.Options_Data.master_volume)
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
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), PlayerData.Options_Data.master_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("MusicBus"), PlayerData.Options_Data.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFXBus"), PlayerData.Options_Data.sfx_volume)
	PlayerData.Options_Data.aiming_cursor_show = aiming_cursor_slider.value
	PlayerData.Options_Data.slots_hint_show = slots_hint_show_slider.value
	PlayerData.Options_Data.look_sensitivity = look_sensitivity_slider.value
	look_sensitivity_label.text = str(PlayerData.Options_Data.look_sensitivity)
	
	if PlayerData.Options_Data.language == "English":
		ma_vol_label.text = "Master Volume"
		so_vol_label.text = "Sound Effects"
		mu_vol_label.text = "Background Music"
		cur_show_label.text = "Aiming Cursor"
		slots_show_label.text = "Slots Hint"
		sens_label.text = "Look Sensitivity"
		lang_label.text = "Language"
		diff_label.text = "Difficulty"
		
		easy_button.text = "Easy"
		normal_button.text = "Normal"
		hard_buttonn.text = "Hard"
		save_button.text = "Save"
		cancel_button.text = "Back"
	elif PlayerData.Options_Data.language == "Spanish":
		ma_vol_label.text = "Volumen Principal"
		so_vol_label.text = "Efectos De Sonido"
		mu_vol_label.text = "Musica De Fondo"
		cur_show_label.text = "Apuntanda El Cursor"
		slots_show_label.text = "Pistas De Tragamonedas"
		sens_label.text = "Mira Sensibilidad"
		lang_label.text = "Idioma"
		diff_label.text = "Dificultad"
		
		easy_button.text = "Facil"
		normal_button.text = "Normal"
		hard_buttonn.text = "Dificil"
		save_button.text = "Salvar"
		cancel_button.text = "Atras"
	elif PlayerData.Options_Data.language == "Filipino":
		ma_vol_label.text = "Dami Ng Master"
		so_vol_label.text = "Mga Sound Effect"
		mu_vol_label.text = "Background Music"
		cur_show_label.text = "Pagpuntirya Ng Cursor"
		slots_show_label.text = "Mga Slot Na Pahiwatig"
		sens_label.text = "Tumungin Ng Sensitivity"
		lang_label.text = "Wika"
		diff_label.text = "Kajirapan"
		
		easy_button.text = "Madali"
		normal_button.text = "Normal"
		hard_buttonn.text = "Mahirap"
		save_button.text = "I-save"
		cancel_button.text = "Bumalik"

func _on_SaveOptions_pressed():
	Global_Player.save_options_data()
	get_parent().get_parent().move_menu_right = true
	#saves changes and returns to other menus

func _on_CancelOptions_pressed():
	#doesnt save changes and returns to other menus
	#need to make it reload the options from start up
	get_parent().get_parent().move_menu_right = true

#languages and difficulties not yet fully implemented
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
