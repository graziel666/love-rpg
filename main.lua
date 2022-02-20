function love.load()
  
  
  tiles = love.graphics.newImage("res/sprites/floor.png")

  local tiles_w = tiles:getWidth()
  local tiles_h = tiles:getHeight()

  --important tiles names
  floor = 13
  torch1 = 11
  torch2 = 6
  spikes = 10
  chest = 15
  stairs = 4
  door = 3

  hero = {
    spr = love.graphics.newImage("res/sprites/hero.png"),
    x=5,
    y=2,
    w=16,
    h=16,
    speed = 16,
    talk = false,
    text = "hi",
    --game objects
    key = 1,
  }

  w = (tiles_w/5)-1
  h = (tiles_h/4) -1

  --others
  animTimer = 100
  map_x = 0
  map_y = 0


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
        {12, 13, 11, 13, 13, 13, 13, 13, 6, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0},
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
        {12, 13, 6, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 4, 13, 14},
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
  --
  
  talk()
  --test
  -- love.graphics.print(hero.x,0,0)
  -- love.graphics.print(hero.y,0,10)
  -- love.graphics.print(animTimer,0,0)

end


function drawMap()
  for i, row in ipairs(map1) do
    for j, tile in ipairs(row) do
      if tile ~=0   then
        love.graphics.draw(tiles, quad[tile], j * w, i * h)
      end
     animTiles(tile,j,i)
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

    test(x,y)
  end
end


function talk()
  if hero.talk == true then
    love.graphics.print(hero.text,8*16,20*16)
  end
end

function test(x,y)
  local map = map1[y][x]
  if map ~= floor then
    hero.talk = true
  end
  if map == floor then
    hero.x = x
    hero.y = y
    hero.talk = false
  elseif map == 8 or map == 14 or map == 18 or map == 12 or map == 20  then
    hero.talk =false
  elseif map == spikes then
    hero.x = x
    hero.y = y
    hero.text = "ouch!"
  elseif map == 3 then
    hero.text = "I can't go back yet!"
  elseif map == torch1 or map == torch2 then
    hero.text = "shiny!"
  elseif map == 15 then
    if hero.key == 0 then
      hero.text = "i need the key..."
    else
      hero.text = "Where it go!?"
      hero.key = hero.key - 1
      map1[y][x] = floor
    end
  end
end


function animTiles(tile,j,i)
  -- love.graphics.print(torch1,0,10)
  if animTimer > 0 then

    if tile == 11 then
      love.graphics.draw(tiles, quad[torch1], j*w, i*h)
    elseif tile == 6 then
      love.graphics.draw(tiles,quad[torch2],j*w, i*h)
    end

    animTimer = animTimer - 1
  end

  if animTimer <= 0 then
    if torch1 == 6 then
      torch1 = 11
    elseif torch1 == 11 then
      torch1 = 6
    end

    if torch2 == 11 then
      torch2 = 6
    elseif torch2 == 6 then
      torch2 = 11
    end

    animTimer = love.math.random(16500,18800)
  end
end

