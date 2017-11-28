-- Вспомогательный скрипт для основного скрипта Player.script, в который
-- вынесены некоторые дополнительные функции-утиллиты (чтобы не загромождать
-- основной скрипт кодом)

require "common"

-- Позиция партии
function get_player_position()
	local pos = go.get_position()
	pos.x = (pos.x + 16) / 16
	pos.y = (pos.y - 64) / 16
	return pos
end

-- Указать героям их позицию
function set_player_position(x, y)
	
end

-- Id тайла карты, на котором находятся герои 
function get_tile_id(current_map_url, current_layer)
	local pos = get_player_position()
	return tilemap.get_tile(current_map_url, current_layer, pos.x, pos.y)
end

-- Изменить id тайлa карты, на котором находятся герои
function set_tile_id(current_map_url, current_layer, tile_id)
	local pos = get_player_position()
	tilemap.set_tile(current_map, current_layer, pos.x, pos.y, tile_id)
end

-- Проходим ли тайл
function can_pass(tile_id)
	_tile = get_tile_id(current_map, layer.event)
	if  _tile == tile.event.no_pass then
		return false
	else
		return true
	end
end

-- Открыть дверь
function open_door()
	set_tile_id(current_map, layer.map, tile.map.odoor)
	set_tile_id(current_map, layer.event, tile.event.empty)
end

-- Закрыть дверь
function close_door()
	set_tile_id(current_map, layer.map, tile.map.cdoor)
	set_tile_id(current_map, layer.event, tile.event.no_pass)
end
