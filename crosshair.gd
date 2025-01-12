extends TextureRect

const close_texture: Texture2D = preload("res://crosshairs/closed.png")
const open_texture: Texture2D = preload("res://crosshairs/open.png")
const x_texture: Texture2D = preload("res://crosshairs/x.png")

func close() -> void:
	texture = close_texture

func open() -> void:
	texture = open_texture

func x() -> void:
	texture = x_texture
