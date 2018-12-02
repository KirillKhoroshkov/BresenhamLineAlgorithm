
function calculatePointsForFirstSector(from, to, width, height)
    local listOfPoints = {}
    local f = 2 * height - width
    local y = from.y
    local yStep
    if (to.y > from.y) then
        yStep = 1
    else
        yStep = -1
    end
    for x = from.x, to.x do
        local point = {
            x = x,
            y = y,
            f = f
        }
        table.insert(listOfPoints, point)
        if f >= 0 then
            y = y + yStep
        end
        if f < 0 then
            f = f + 2 * height
        else
            f = f - 2 * (width - height)
        end
    end
    return listOfPoints
end

function calculatePoints(from, to)
    local width = to.x - from.x
    local height = to.y - from.y
    if width < 0 then
        return calculatePoints(to, from)
    elseif height < 0 then
        height = - height
    end
    if (height > width) then
        from.x, from.y = from.y, from.x
        to.x, to.y = to.y, to.x
        local list = calculatePoints(from, to)
        for _, dot in pairs(list) do
            dot.x, dot.y = dot.y, dot.x
        end
        return list
    else
        return calculatePointsForFirstSector(from, to, width, height)
    end
end

local from = {
    x = io.read("*n"),
    y = io.read("*n")
}
local to = {
    x = io.read("*n"),
    y = io.read("*n")
}

local points = calculatePoints(from, to)
print("X", "Y", "F")
for _, point in pairs(points) do
    print(point.x, point.y, point.f)
end