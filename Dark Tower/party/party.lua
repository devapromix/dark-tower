require "party/common"
require "party/inventory"

-- Герои
heroes = {
	-- Кол-во героев на выбор
	amount = 7,
	-- Имя
	name =         {"Грогнар", "Сир Тавор", "Хартан", "Сорен",  "Фальмиор",  "Тилия",    "Шенна",},
	-- Класс
	class =        {"варвар",  "рыцарь",    "вор",    "лучник", "волшебник", "амазонка", "колдунья",},
	-- Сила
	strength =     {10,        8,           4,        6,        3,           7,          4,},
	-- Ловкость
	accuracy =     {2,         5,           10,       9,        5,           10,         6,},
	-- Здоровье
	hit_points =   {14,        12,          8,        10,       7,           11,         9,},
}

-- Партия
party = {
	-- Кол-во героев в партии
	amount = 0,
	-- Имя
	name = {},
	-- Уровень
	level = {},
	-- Класс
	class = {},
	-- Сила
	strength = {},
	-- Ловкость
	accuracy = {},
	-- Здоровье (Хиты)
	min_hp = {},
	max_hp = {},
}

-- Добавить героя в партию
function add_hero_to_party(i)
	-- Проверка на уникальность
	f = true
	if party.amount > 0 then
		for j = 1,party.amount do
			if party.name[j] == heroes.name[i] then
				f = false
				break
			end
		end
	end
	-- Добавляем нового героя в партию
	if f and party.amount < 3 then
		party.amount = party.amount + 1
		-- Новый герой в партии
		party.name[party.amount] = heroes.name[i]
		party.level[party.amount] = 1
		party.class[party.amount] = heroes.class[i]
		party.strength[party.amount] = heroes.strength[i]
		party.accuracy[party.amount] = heroes.accuracy[i]
		-- Здоровье
		party.min_hp[party.amount] = heroes.hit_points[i]
		party.max_hp[party.amount] = heroes.hit_points[i]
	end
end

-- Тест
add_hero_to_party(math.random(1, heroes.amount + 1))
add_hero_to_party(math.random(1, heroes.amount + 1))
add_hero_to_party(math.random(1, heroes.amount + 1))

print("Состав партии:")
for i=1,party.amount do
	print(party.name[i]..", "..party.class[i]..", уровень "..party.level[i])
end
