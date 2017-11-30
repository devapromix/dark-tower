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
		class= "варвар",
		-- Сила
		strength = 10,
		-- Ловкость
		accuracy = 3,
		-- Здоровье
		hit_points = 14,
	},
	-- Сир Тавор #2
	{
		name = "Сир Тавор",
		class= "рыцарь",
		strength = 8,
		accuracy = 5,
		hit_points = 12,
	},
	-- Вор Хартан #3
	{
		name = "Хартан",
		class= "вор",
		strength = 4,
		accuracy = 10,
		hit_points = 8,
	},
	-- Сорен #4
	{
		name = "Сорен",
		class= "лучник",
		strength = 6,
		accuracy = 9,
		hit_points = 10,
	},
	-- Фальмиор #5
	{
		name = "Фальмиор",
		class= "волшебник",
		strength = 3,
		accuracy = 5,
		hit_points = 7,
	},
	-- Тилия #6
	{
		name = "Тилия",
		class= "амазонка",
		strength = 7,
		accuracy = 10,
		hit_points = 11,
	},
	-- Шенна #7
	{
		name = "Шенна",
		class= "колдунья",
		strength = 4,
		accuracy = 6,
		hit_points = 9,
	},
}

-- Партия
party = {
	-- Кол-во героев в партии
	amount = 0,
	-- Инвентарь
	inventory = {},
	-- Текущая карта
	current_map = "",
	-- Герои
	{1}, {2}, {3},
}

-- Добавить героя в партию
-- id - номер героя в массиве heroes
function party:add_hero(id)
	-- Проверка на уникальность
	f = true
	if party.amount > 0 then
		for j = 1,party.amount do
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
		-- Уровень
		party[party.amount].level = 1
		-- Класс
		party[party.amount].class = heroes[id].class
		-- Сила
		party[party.amount].strength = heroes[id].strength
		-- Ловкость
		party[party.amount].accuracy = heroes[id].accuracy
		-- Здоровье
		party[party.amount].min_hp = heroes[id].hit_points
		party[party.amount].max_hp = heroes[id].hit_points
	end
end

-- Тест
for i=1,3 do
	party:add_hero(math.random(1, #heroes + 1))
end

print("Состав партии:")
for i=1,party.amount do
	print(party[i].name..", "..party[i].class..", уровень "..party[i].level)
end
