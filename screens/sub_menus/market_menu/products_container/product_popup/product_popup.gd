class_name ProductPopup extends Control

signal buy_product_input_received(product_name:String, product_price:int)
signal cancel_input_received

@onready var _product_thumbnail : Sprite2D = $ProductThumbnail
@onready var _pricetag_label : Label = $PricetagLabel
@onready var _description_label : Label = $DescriptionLabel

var _product_name : String
var _product_price : int


func set_product(product_name:String ,product_texture:Texture, product_price:int, product_description:String):
	_product_name = product_name
	_product_thumbnail.texture = product_texture
	_product_price = product_price
	_pricetag_label.text = str(_product_price)
	_description_label.text = product_description


func _on_buy_button_pressed():
	buy_product_input_received.emit(_product_name, _product_price)

func _on_cancel_button_pressed():
	cancel_input_received.emit()
