class_name MarketMenu extends Control

signal go_back

var _player_user_data : PlayerUserData = UserDataManager.user_data.player_user_data

@onready var _user_balance_displayer : UserBalanceDisplayer = $UserBalanceDisplayer as UserBalanceDisplayer
@onready var _products_container : ProductsContainerGrid = $ProductsContainerGrid as ProductsContainerGrid
@onready var _product_popup : ProductPopup = $ProductPopup as ProductPopup

func _ready():
	_update_user_balance_displayer()
	_set_products_container()
	_connect_product_popup_signals()
	
func _connect_product_popup_signals():
	_product_popup.buy_product_input_received.connect(_on_product_popup_buy_input_received)
	_product_popup.cancel_input_received.connect(_on_product_popup_cancel_input_received)

func _set_products_container():
	_products_container.product_button_pressed.connect(_on_product_button_pressed)

func _update_user_balance_displayer():
	_user_balance_displayer.balance = _player_user_data.player_balance
	
func _on_go_back_button_pressed():
	$SFXPlayer.play_sound()
	go_back.emit()

func _on_product_button_pressed(product_button:BuyProductButton):
	if _player_user_data.player_balance < product_button.product_price:
		printt("Not enough balance")
		return
	
	_product_popup.set_product(product_button.product_name, product_button.product_thumbnail, product_button.product_price, product_button.product_description)
	_product_popup.visible = true

func _on_product_popup_buy_input_received(product_name:String, product_price:int):
	match product_name:
		"7SlotsUpgrade":
			_player_user_data.unlocked_ally_slots = 7
	_player_user_data.player_balance -= product_price
	UserDataManager.save_user_data_to_disk()
	_update_user_balance_displayer()

	_product_popup.visible = false


func _on_product_popup_cancel_input_received():
	_product_popup.visible = false


