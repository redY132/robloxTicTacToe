--testing
--board is a 3d array ex: 
local intBoard = {
  {
    {-1, -1, -1},
    {-1, 1, -1},
    {-1, -1, 1}
  },
  {
    {-1, -1, -1},
    {-1, -1, -1},
    {0, -1, -1},
  },
  {
    {1, -1, -1},
    {1, -1, -1},
    {-1, -1, -1},
  }
}

local placement = {x = 2, y = 2, z = 2}

--args: board = 1d array, width = int
local function xCheck(board, width)

  local sum = 0
  for _, value in ipairs(board) do
    sum = sum + value
  end

  if sum == width or sum == -width then
    return true
  end

  return false
end

--args: board = 2d array, x = int, height = int
local function yCheck(board, x, height)

  local sum = 0

  for _, row in ipairs(board) do
    sum = sum + row[x]
  end

  if sum == height or sum == -height then
    return true
  end

  return false
end

--args: board = 2d array, x = int, y = int, size = int
local function twoDiagonalCheck(board, x, y, size)

  --checking if x and y are on northeast/southwest diagonal 
  --checking if x and y are on southeast/northwest diagonal
  if x ~= y or (size + 1) ~= (x + y) then
    return false
  end

  --northwest/southeast sum
  local sum1 = 0
  for index, row in ipairs(board) do
    sum1 = sum1 + row[index]
  end

  if sum1 == size or sum1 == -size then
    return true
  end

  --northeast/southwest sum
  local sum2 = 0
  for index, row in ipairs(board) do
    sum2 = sum2 + row[size - index + 1]
  end

  if sum2 == size or sum2 == -size then
    return true
  end

  return false
end

--args: board = 3d array, depth = int
local function zDownCheck(board, x, y, depth)

  local sum = 0
  for _, twoBoard in ipairs(board) do
    sum = sum + twoBoard[y][x]
  end

  if sum == depth or sum == -depth then
    return true
  end

  return false
end

--args: board = 3d array, depth = int, x = int, y = int, size = int
local function threeDiagonalCheck(board, x, y, z, size)

  --checking if x and y coordinates can make a diagonal
  local viableXLeft = (x == z)
  local viableXRight = (x == (size - z + 1))
  local viableYTop = (y == z)
  local viableYBot = (y == (size - z + 1))

  local viableX = viableXLeft or viableXRight
  local viableY = viableYTop or viableYBot

  --early stop
  if ((not viableX) and (not viableY)) then
    return false
  end

  if viableXLeft then

    local sum = 0
    for index, twoBoard in ipairs(board) do
      sum = sum + twoBoard[y][index]
    end

    if sum == size or sum == -size then
        return true
    end

  end

  if viableXRight then

    local sum = 0
    for index, twoBoard in ipairs(board) do
      sum = sum + twoBoard[y][size - index + 1]
    end

    if sum == size or sum == -size then
      return true
    end
  end

  if viableYTop then

    local sum = 0
    for index, twoBoard in ipairs(board) do
      sum = sum + twoBoard[index][x]
    end

    if sum == size or sum == -size then
      return true
    end
  end

  if viableYBot then

    local sum = 0
    for index, twoBoard in ipairs(board) do
      sum = sum + twoBoard[size - index + 1][x]
    end

    if sum == size or sum == -size then
      return true
    end

  end

  if viableXLeft and viableYTop then

    local sum = 0
    for index, twoBoard in ipairs(board) do
      sum = sum + twoBoard[index][index]
    end

    if sum == size or sum == -size then
      return true
    end
  end

  if viableXRight and viableYBot then

    local sum = 0
    for index, twoBoard in ipairs(board) do
      sum = sum + twoBoard[index][size - index + 1]
    end

    if sum == size or sum == -size then
      return true
    end
  end

  return false

end

--game end check function takes in intboard and coordinates as tuple
local function gameEnd(board, cords)

  local size = #board

  local gameEnded = false
  gameEnded = gameEnded or xCheck(board[cords.z][cords.y], size)
  gameEnded = gameEnded or yCheck(board[cords.z], cords.x, size)
  gameEnded = gameEnded or twoDiagonalCheck(board[cords.z], cords.x, cords.y, size)
  gameEnded = gameEnded or zDownCheck(board, cords.x, cords.y, size)
  gameEnded = gameEnded or threeDiagonalCheck(board, cords.x, cords.y, cords.z, size)

  return gameEnded
end

print(gameEnd(intBoard, placement))
