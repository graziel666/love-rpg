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
        {12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 6, 14},
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

  --test
  love.graphics.print(hero.x,0,0)
  love.graphics.print(hero.y,0,10)
  
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
    if key == "a" then
        hero.x = hero.x - 1
    elseif key == "d" then
        hero.x = hero.x + 1
    elseif key == "w" then
        hero.y = hero.y - 1
    elseif key == "s" then
        hero.y = hero.y + 1
    end
  end
end
