-- Все герои, которых можно выбрать себе в партию.
-- Партия состоит из 3-х героев и одного на всех инвентаря.

require "party/common"
require "party/inventory"

-- Герои для выбора в партию
heroes = {
	-- Грогнар-варвар #1
	{
		-- Имя
		name = "Грогнар",
		-- Класс
		class = "warrior",
		-- Название класса
		class_name= "варвар",
		-- Сила
		strength = 10,
		-- Ловкость
		accuracy = 3,
		-- Телосложение
		constitution = 11,
		-- Интеллект
		intelligence = 3,
		-- Здоровье
		hit_points = 14,
		-- Мана
		mana_points = 1,
	},
	-- Сир Тавор #2
	{
		name = "Сир Тавор",
		class = "warrior",
		class_name = "рыцарь",
		strength = 8,
		accuracy = 5,
		constitution = 10,
		intelligence = 3,
		hit_points = 12,
		mana_points = 5,
	},
	-- Вор Хартан #3
	{
		name = "Хартан",
		class = "thief",
		class_name = "вор",
		strength = 4,
		accuracy = 10,
		constitution = 3,
		intelligence = 3,
		hit_points = 8,
		mana_points = 6,
	},
	-- Сорен #4
	{
		name = "Сорен",
		class = "archer",
		class_name = "лучник",
		strength = 6,
		accuracy = 9,
		constitution = 3,
		intelligence = 3,
		hit_points = 10,
		mana_points = 4,
	},
	-- Фальмиор #5
	{
		name = "Фальмиор",
		class = "wizzard",
		class_name = "волшебник",
		strength = 3,
		accuracy = 5,
		constitution = 3,
		intelligence = 16,
		hit_points = 7,
		mana_points = 15,
	},
	-- Тилия #6
	{
		name = "Тилия",
		class = "warrior",
		class_name = "амазонка",
		strength = 7,
		accuracy = 10,
		constitution = 6,
		intelligence = 3,
		hit_points = 11,
		mana_points = 3,
	},
	-- Шенна #7
	{
		name = "Шенна",
		class = "wizzard",
		class_name = "колдунья",
		strength = 4,
		accuracy = 6,
		constitution = 3,
		intelligence = 14,
		hit_points = 9,
		mana_points = 12,
	},
}

-- Партия
party = {
	-- Кол-во героев в партии
	amount = 0,
	-- Инвентарь
	inventory = {
		-- Размер инвентаря
		max_size = 10,
		-- Золото
		gold = 50,
	},
	-- Текущая карта
	current_map = "",
	-- Герои
	{1}, {2}, {3},
	-- Очки
	score = 0,
}

-- Есть ли у партии нужная сумма денег
function party:has_gold(value)
	r = false
	if value >= 0 then
		r = party.inventory.gold >= value
	end
	return r
end

--
function party:add_item_to_inventory(item_id)

end

--
function party:use_item(item_id)

end

--
function party:equip_item(char_id, item_id)

end

--
function party:unequip_item(char_id, item_id)

end

--
function party:remove_item_from_inventory(item_id)

end

-- Сколько опыта нужно накопить до след. уровня
function party:xp_to_next_level(current_level)
	return (current_level + 1) * 30
end

-- Добавляем опыт партии
function party:add_exp(value)
	if value > 0 and party.amount > 0 then
		-- Опыт каждому герою партии
		value = math.ceil(value / party.amount)
		for i = 1, party.amount do
			party[i].experience = party[i].experience + value
			-- Если опыта больше, то новый уровень
			if party[i].experience > party:xp_to_next_level(party[i].level) then
				party[i].level = party[i].level + 1
			end
		end
	end
end

-- Добавить героя в партию
-- id - номер героя в массиве heroes
function party:add_hero(id)
	-- Проверка на уникальность
	f = true
	if party.amount > 0 then
		for j = 1, party.amount do
			if party[j].name == heroes[id].name then
				f = false
				break
			end
		end
	end
	-- Добавляем нового героя в партию
	if f and party.amount < 3 then
		-- Новый герой в партии
		party.amount = party.amount + 1
		-- Сохраняем id героя
		party[party.amount].id = id
		-- Имя
		party[party.amount].name = heroes[id].name
		-- Класс
		party[party.amount].class = heroes[id].class
		-- Название класса
		party[party.amount].class_name = heroes[id].class_name
		-- Сила
		party[party.amount].strength = heroes[id].strength
		-- Ловкость
		party[party.amount].accuracy = heroes[id].accuracy
		-- Телосложение
		party[party.amount].constitution = heroes[id].constitution
		-- Интеллект
		party[party.amount].intelligence = heroes[id].intelligence
		-- Здоровье
		party[party.amount].min_hp = heroes[id].hit_points
		party[party.amount].max_hp = heroes[id].hit_points
		-- Мана
		party[party.amount].min_mp = heroes[id].mana_points
		party[party.amount].max_mp = heroes[id].mana_points
		-- Уровень
		party[party.amount].level = 1
		-- Опыт
		party[party.amount].experience = 0
		-- Экипировка
		equipment = {}
	end
end

-- Тест
for i=1,3 do
	party:add_hero(math.random(1, #heroes + 1))
end

print("Состав партии:")
for i=1,party.amount do
	print(party[i].name..", "..party[i].class_name..", уровень "..party[i].level)
end
