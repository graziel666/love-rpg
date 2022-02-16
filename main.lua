function love.load()

  tiles = love.graphics.newImage("res/sprites/floor.png")

  local tiles_w = tiles:getWidth()
  local tiles_h = tiles:getHeight()

  hero = {
    spr = love.graphics.newImage("res/sprites/hero.png"),
    x=5,
    y=2,
    w=16,
    h=16,
    speed = 16,
    talk = false,
    text = "hi",
  }

  w = (tiles_w/5)-1
  h = (tiles_h/4) -1


  --quads
  quad = {}

  for i=0,3 do
    for j=0,4 do
      table.insert(quad, love.graphics.newQuad(1+j*(w+1),1+i*(h+1), w, h, tiles_w, tiles_h))
    end
  end

  --maps
  map1 = {
        {7, 8, 8, 8, 3, 8, 8, 8, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0},
        {12, 13, 11, 13, 13, 13, 13, 13, 11, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 20, 8, 8, 8, 8, 9, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 13, 13, 13, 13, 14, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 13, 13, 15, 13, 14, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 13, 13, 13, 13, 14, 0, 0, 0},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 20, 8, 8, 9},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 11, 13, 14},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14},
        {12, 13, 11, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 4, 13, 14},
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14},
        {17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19}
        }

end

function love.update(dt)
  playerInput()
end


function love.draw()
  drawMap()

  --draw Player
  love.graphics.draw(hero.spr, hero.x * w, hero.y * h)

  talk()
  --test
  -- love.graphics.print(hero.x,0,0)
  -- love.graphics.print(hero.y,0,10)
  
end


function drawMap()
  for i, row in ipairs(map1) do
    for j, tile in ipairs(row) do
      if tile ~=0 then
        love.graphics.draw(tiles, quad[tile], j * w, i * h)
      end
    end
  end
end



function playerInput()
  function love.keypressed(key)
    local x = hero.x
    local y = hero.y

    if key == "a" then
        x = x - 1
    elseif key == "d" then
        x = x + 1
    elseif key == "w" then
        y = y - 1
    elseif key == "s" then
        y = y + 1
    end

    if isFloor(x,y) then
      hero.x = x
      hero.y = y
      hero.talk = false
    else 
      hero.talk = true
      hero.text = "I can't walk there"
    end
  end
end

function isFloor(x,y)
  return map1[y][x] == 13
end

function talk()
  if hero.talk == true then
    love.graphics.print(hero.text,8*16,20*16)
  end
end
