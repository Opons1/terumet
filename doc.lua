--this is based on the wiki
doc.add_category("terumet", {
    name = "Terumet",
    description = "Information related to Terumet including machines and items",
    build_formspec = doc.entry_builders.text_and_gallery,
    sorting = "custom",
    sorting_data = {"heat", "heatline", "alloy_smelter", "furnace_heater", "thermaldist", "crusher", "thermobox"}
})
--ALLOY SMELTER
local alloy_smelter = terumet.options.smelter
local string = "The Alloy Smelter in Terumet is the first machine you need to make. "
    .. "To fuel, place a lava bucket in the Heat In slot. "
    .. "The materials produced here are the core crafting components of the Terumet mod. "
    .. "Some recipes require flux, which is obtained by putting terumetal inside the alloy furnace. "
    .. "Multiple forms of terumetal are accepted, but some forms become flux faster than others. "
    .. "Raw lumps take 3 seconds, ingots take 2, and crystallized terumetal takes 1. "
    .. "When dug, the flux stored inside falls out as crystallized terumetal. "
    .. "\n"
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax Heat: " .. alloy_smelter.MAX_HEAT
    .. "\nFlux per Terumetal: " .. alloy_smelter.FLUX_VALUE
    .. "\nMax Stored Flux: " .. alloy_smelter.FLUX_MAXIMUM
    .. "\nHeat Consumed/sec when melting flux: " .. alloy_smelter.MELT_HUPS
    .. "\nHeat Consumed/sec when alloying " ..  alloy_smelter.ALLOY_HUPS
    .. "\n"
    .. "\nRECIPES:"
for index, recipe in ipairs(alloy_smelter.recipes) do
    local input = recipe.input
    local inputreformatted = {}
    local output = ItemStack(recipe.result):get_count() .. " " .. (ItemStack(recipe.result):get_short_description() or ItemStack(recipe.result):get_description())
    for _, item in pairs(input) do
        local itemdesc = ItemStack(item):get_short_description() or ItemStack(item):get_description()
        local count = ItemStack(item):get_count()
        local itemstr
        if count ~= 1 then
            itemstr = count .. " " .. itemdesc
        else
            itemstr = itemdesc
        end
        table.insert(inputreformatted, itemstr)
    end
    local inputstr = table.concat(inputreformatted, ", ")
    string = string .. 
    "\nOutput: " .. output .. " | Recipe: " .. inputstr .. " | Flux Used: " .. recipe.flux .. " | ".. recipe.time .. " Second(s)\n"
end
doc.add_entry("terumet", "alloy_smelter", {
    name = "Terumetal Alloy Smelter",
    data = {
        text = string,
        images = {{image = "smelter_recipe.png"}, {image = "smelter_gui.png"}, {image = "smelter_fueling.png"}, {image = "smelter_fueling_2.png"}, {image = "smelter_melting_flux.png"}, {image = "smelter_melting_flux_2.png"} }
    }
})
local cry_vulc = terumet.options.vulcan
--CRYSTAL VULCANISER
string = "The Crystal Vulcanizer, by rapidly switching between two specific temperatures, can crystallize many ores and some other materials. The crystallized material can be cooked for an increased mineral yield. Metal lumps can be inserted for crystallization, but for gems such as diamonds and mese, you need to get the ore block, usually done by an Ore-cutting Saw. Also, some upgrades increase yield of crystals.\n"
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax Heat: " .. cry_vulc.MAX_HEAT
    .. "\nHeat Consumed/sec when vulcanizing: " .. cry_vulc.VULCANIZE_HUPS
    .. "\nProcess Time: " .. cry_vulc.PROCESS_TIME
    .. "\n"
for index, recipe in pairs(cry_vulc.recipes) do
    local inputstr = ItemStack(index):get_description()
    local inputreformatted = {}
    local output =  recipe[2] .. " " .. (ItemStack(recipe[1]):get_short_description() or ItemStack(recipe[1]):get_description())
    string = string .. 
    "\nOutput: " .. output .. " | Recipe: " .. inputstr .. "\n"
end
doc.add_entry("terumet", "vulcanizer", {
    name = "Crystal Vulcanizer",
    data = {
        text = string
    }
})
--EEE HEATER
local entropy = terumet.options.heater.entropy
string = "The EEE Heater is the most powerful heater in this mod. It harnesseses the Universes entropy, causing its surroundings to decay in the process. To build, just place the EEE heater and a entropic matrix on top."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax Heat: " .. entropy.MAX_HEAT
    .. "\nHeat Transfer Rate: " .. entropy.HEAT_TRANSFER_RATE
    .. "\nDefault Decay Time(when the decay time isnt specified below): " .. entropy.DEFAULT_DRAIN_TIME 
    .. "\nMax Range: " .. core.serialize(entropy.MAX_RANGE)
    .. "\n\nHUPS per node and what it transforms into:"
for item, result in pairs(entropy.EFFECTS) do
    if ItemStack(item):is_known() then
        string = string .. "\n" .. ItemStack(item):get_description() .. " turns tnto " .. ItemStack(result.change):get_description() .. " producing " .. result.hups .. " heat/sec over " .. (result.time or 1) .. " seconds.\n"
    else
        string = string .. "\n" .. item .. " turns into " .. ItemStack(result.change):get_description() .. " producing " .. result.hups .. " heat/sec over " .. (result.time or 1) .. " seconds.\n"
    end
end
doc.add_entry("terumet", "entropy", {
    name = "EEE Heater",
    data = {
        text = string
    }
})
--EQUIPMENT REFORMER
local reformer = terumet.options.repm
string = "The equipment reformer utilizes crystallized repair material extracted from various default and terumet metals to repair certain terumet tools. The usefullness of this is when you can repair valuable tools with common materials such as steel and bronze."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax Heat: " .. reformer.MAX_HEAT
    .. "\nHeat/sec used to obtain repair material: " .. reformer.MELT_HUPS
    .. "\nRepair material obtained/sec: " .. reformer.MELTING_RATE  
    .. "\nHeat/sec used to repair: " .. reformer.REPAIR_HUPS
    .. "\nRepair material consumed/sec: " .. reformer.REPAIR_RATE  
    .. "\nMax stored repair material: " .. reformer.RMAT_MAXIMUM
    .. "\n\nItems that produce repair material:\n\n"
for item, count in pairs(reformer.repair_mats) do
    local itemname = ItemStack(item):get_description()
    string = string .. itemname .. " produces " ..  count .. " repair material.\n\n"
end
doc.add_entry("terumet", "reformer", {
    name = "Equipment Reformer",
    data = {
        text = string
    }
})
--EXPANSION CRUSHER
local crusher = terumet.options.crusher
string = "The Expansion Crusher is used to crush things.\n"
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. crusher.MAX_HEAT
    .. "\nHeat used per second: " .. crusher.HEAT_HUPS
    .. "\nHeating time: " .. crusher.TIME_HEATING
    .. "\nCooling time: " .. crusher.TIME_COOLING
    .. "\n\nRecipes:\n\n"
for input, output in pairs(crusher.recipes) do
    local inputname
    local outputname
    if ItemStack(input):is_known() then
        inputname = ItemStack(input):get_short_description() or ItemStack(input):get_description()
    else
        inputname = input
    end
    if ItemStack(output):is_known() then
        outputname = ItemStack(output):get_short_description() or ItemStack(output):get_description()
    else
        outputname = output
    end
    string = string .. inputname .. " ---> " ..  outputname .. "\n\n"
end
doc.add_entry("terumet", "crusher", {
    name = "Expansion Crusher",
    data = {
        text = string
    }
})
--FURNACE HEATER
local heater = terumet.options.heater.furnace
string = "The Furnace Heater is the most basic heater. It takes anything that can be burned and burns it to produce heat."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. heater.MAX_HEAT
    .. "\nHeat produced per second: " .. heater.GEN_HUPS
    .. "\nHeat transfer rate:  " .. heater.HEAT_TRANSFER_RATE

doc.add_entry("terumet", "furnace_heater", {
    name = "Furnace Heater",
    data = {
        text = string
    }
})
--HEAT RAY EMMITTER AND REFLECTOR
local emit = terumet.options.heat_ray
string = "The Heat Ray Emmiter is an advanced method of heat transfer over the air and long distances. It stores heat until it has enough to fire, through the small circular opening on the decorated side. When has enough, it scans ahead to look for a target machine. The emmitters scan continues until it finds a target, unloaded area, obstruction(node), or exceeds its limit of " .. emit.MAX_DISTANCE .. " blocks. The heat ray can turn with the use of the Heat Ray Reflector, which will redirect the ray to its decorated side."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. emit.MAX_HEAT
    .. "\nHeat sent: " .. emit.SEND_AMOUNT
    .. "\nMax distance  " .. emit.MAX_DISTANCE

doc.add_entry("terumet", "heat_ray_emit_reflect", {
    name = "Heat Ray Emitter and Reflector",
    data = {
        text = string
    }
})
--HEATLINES and distributors
local heatline = terumet.options.heatline
string = "Heatlines are cables that transfer heat from a Heatline Distributor. Place the distributor adjacent to a heater(something that makes heat like furnace heater), and connect the distributor to other machines via normal or embedded heatlines, and it will send heat to all the connected machines every second, dividings its transfer rate among them. The embedded heatlines are heatlines in nodes, to prevent holes and make them fit better with their surroundings."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. heatline.MAX_HEAT
    .. "\nMax heatline lenght " .. heatline.MAX_DIST
    .. "\nHeat transfer rate(divided among all the machines):  " .. heatline.HEAT_TRANSFER_MAX

doc.add_entry("terumet", "heatline", {
    name = "Heatlines and Distributors",
    data = {
        text = string
    }
})
--HIGH TEMPERATURE FURNACE
local furn = terumet.options.furnace
string = "The High Temperature Furnace is a faster furnace fueled by heat."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax Heat: " .. furn.MAX_HEAT
    .. "\nHeat Consumed/sec: " .. furn.COOK_HUPS
    .. "\nSpeed Multiplier: " .. (1/furn.TIME_MULT)

doc.add_entry("terumet", "furnace", {
    name = "High Temperature Furnace",
    data = {
        text = string
    }
})
--LAVAMELTER
local lavam = terumet.options.lavam
string = "The lava melter takes valid stones, a very large amount of heat, and a very long amount of time to place lava in front of it. The heat used per second is the total heat consumed/melt time."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. lavam.MAX_HEAT
    .. "\nMelting time: " .. lavam.MELT_TIME
    .. "\n\nValid Stones: \n\n"
    for stone, heat in pairs(lavam.VALID_STONES) do
        local itemname = ItemStack(stone):get_description()
        string = string .. itemname .. " using " .. heat .. " heat. \n"
    end

doc.add_entry("terumet", "lavamelter", {
    name = "Lava Melter",
    data = {
        text = string
    }
})
--heat
string = "Heat is the resource that powers terumet machines. "  
    .. "Early machines have a slot in the top left where you can insert heat sources such as full terumet batteries and lava buckets. "
    .. "Heat batteries are fueled by putting either cooking in a furnace or putting it in the Heat Out slot. "
    .. "External Heaters will eventually be necessary however, the simplest being a furnace heater. "
    .. "Heat can also be transferred via heatlines or heat rays and stored through thermoboxes. "

doc.add_entry("terumet", "heat", {
    name = "Heat",
    data = {
        text = string
    }
})
--mese garden
local meseg = terumet.options.meseg
-- i may need to fix this one
string = "Mese Garden is a machine that can grow mese from crystals. It starts at low efficiency, but given a consistent supply of mese and heat, as well as a free output slot, it will scale its efficiency until it reaches a maximum value. It rapidly loses efficiemcy when these needs are not met. Mese crystals have a chance to dissapear when making a fragment, and both the chance and production speed increases the more mese crystals you fuel it with."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax Heat: " .. meseg.MAX_HEAT
    .. "\nStartup heat cost: " .. meseg.START_HEAT
    .. "\nHeat Consumed/sec: " .. meseg.HEAT_HUPS
    .. "\nEFficiency gain rate: Number of seed crystals per second"
    .. "\nEfficiency loss rate(this much percent is lost per second): " .. meseg.EFFIC_LOSS_RATE
    .. "\nSeed item: " .. ItemStack(meseg.SEE_ITEM):get_description()
    .. "\nProduced item " .. ItemStack(meseg.PRODUCE_ITEM):get_description()
    .. "\nSeed loss chance: 1 - " .. meseg.SEED_LOSS_CHANCE .. "/seed crystal count"

doc.add_entry("terumet", "meseg", {
    name = "Mese Garden",
    data = {
        text = string
    }
})
--ore cutting saw
local oresaw = terumet.options.ore_saw
string = "The ore saw can be used to relocate ores. The primary use of this is to obtain mese and diamond oreblocks to vulcanize, but you can relocate most ores with this."
    .. "The basic saw has " .. oresaw.BASIC_USES .. " uses, and the advanced ones has " .. oresaw.ADVANCED_USES .. " uses."

doc.add_entry("terumet", "oresaw", {
    name = "Ore-cutting Saw",
    data = {
        text = string
    }
})
--solar heater
local sheat = terumet.options.heater.solar
string = "The solar heater generates heat based on the level of light sunlight is making."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. sheat.MAX_HEAT
    .. "\nHeat produced per second(all levels of production): " .. table.concat(sheat.SOLAR_HUPS, ", ")
    .. "\nHeat transfer rate:  " .. sheat.HEAT_TRANSFER_RATE

doc.add_entry("terumet", "solarheater", {
    name = "Solar Heater",
    data = {
        text = string
    }
})

--Thermal Distributor
local tdist = terumet.options.thermdist
string = "The thermal distributor is a machine that has one heat input side and 5 heat output sides. It distributes heat to adjacent machines."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. tdist.MAX_HEAT
    .. "\nHeat transfer rate:  " .. tdist.HEAT_TRANSFER_RATE

doc.add_entry("terumet", "thermaldist", {
    name = "Thermal Distributor",
    data = {
        text = string
    }
})

--Thermobox
local tbox = terumet.options.thermobox
string = "The thermobox is a machine that stores a large amount of heat, and sends it to the decorated side, where a machine should be."
    .. "\nMachine Stats(these can be changed with upgrades): "
    .. "\nMax heat: " .. tbox.MAX_HEAT
    .. "\nHeat transfer rate: " .. tbox.HEAT_TRANSFER_RATE
doc.add_entry("terumet", "thermobox", {
    name = "Thermobox",
    data = {
        text = string
    }
})

