local component = require('component')
local xnet = component.xnet
local sides = require("sides")

local serialization = require('serialization')
local s = serialization.serialize

local xblocks = xnet.getConnectedBlocks()
local blocks = {}

local args = {...}

function table_all_p(p, t)
  for _,v in pairs(t) do
    if not p(v) then return false end
  end

  return true
end

function table_filter(p, t)
  local out = {}
  for _,v in pairs(t) do
    if p(v) then table.insert(out, v) end
  end

  return out
end

function is_table_p(value)
  return type(value) == "table" and true or false
end

function is_inventory_p(t)
  if not is_table_p(t) then return false end

  if t.damage ~= nil and t.maxDamage ~= nil and t.label ~= nil then
    return true
  else
    return false
  end
end

function empty_p(slot)
  if type(slot) ~= "table" then return true end
  return slot.name ~= "minecraft:air" and true or false
end

function inventory_empty_p(inventory)
  table_all_p(empty_p, table_filter(is_inventory_p, inventory))
end

for _,v in pairs(xblocks) do
  if type(v) == "table" and v.connector ~= nil then
    blocks[v.connector] = v
  end
end

local block = blocks[args[1]]
if block ~= nil then
  for i=0,5 do
    local items = xnet.getItems(block.pos, i)
    local itemstring

    if items ~= nil then
      if inventory_empty_p(items) then
        itemstring = "Empty"
      else
        itemstring = s(items)
      end

      print("Side", sides[i], "\t", itemstring, "\n")
    end
  end
end
