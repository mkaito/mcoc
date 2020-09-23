component = require 'component'
sides = require 'sides'
serialization = require 'serialization'

xnet = component.xnet
s = serialization.serialize

list_all = (p, l) ->
  for v in *l
    return false if not p(v)
  true

is_slot = (i) ->
  type(i) == "table" and i.damage != nil and i.maxDamage != nil and i.name != nil

is_inventory = (i) ->
  list_all is_slot, i

slot_empty = (slot) ->
  slot.name == "minecraft:air"

inventory_empty = (i) ->
  list_all slot_empty, i

xblocks = xnet.getConnectedBlocks!
blocks = {v.connector, v for v in *xblocks when type(v) == "table" and v.connector != nil}

args = {...}
block = blocks[args[1]]

for i = 0,5
  inventory = xnet.getItems block.pos, i

  if inventory != nil and is_inventory(inventory) and not inventory_empty(inventory)
    print sides[i], s(inventory), "\n"
