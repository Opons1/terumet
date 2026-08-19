--Thanks to LadyK for colors
local c = {}

c.crys_chromium = terumet.register_crystal({
    suffix = "chromium",
    color = "#c9c9c9",
    name = "Crystallized Chromium",
    cooking_result = "technic:chromium_ingot"
})

c.crys_lead = terumet.register_crystal({
    suffix = "lead",
    color = "#969696",
    name = "Crystallized Lead",
    cooking_result = "technic:lead_ingot"
})

c.crys_uranium = terumet.register_crystal({
    suffix = "uranium",
    color = "#a0ffa6",
    name = "Crystallized Uranium",
    cooking_result = "technic:uranium_ingot"
})

c.crys_zinc = terumet.register_crystal({
    suffix = "zinc",
    color = "#ccdae0",
    name = "Crystallized Zinc",
    cooking_result = "technic:zinc_ingot"
})

terumet.register_vulcan_result("technic:mineral_chromium", c.crys_chromium, 1)
terumet.register_vulcan_result("technic:mineral_lead", c.crys_lead, 1)
terumet.register_vulcan_result("technic:mineral_uranium", c.crys_uranium, 1)
terumet.register_vulcan_result("technic:mineral_zinc", c.crys_zinc, 1)

terumet.register_vulcan_result("technic:chromium_lump", c.crys_chromium)
terumet.register_vulcan_result("technic:lead_lump", c.crys_lead)
terumet.register_vulcan_result("technic:uranium_lump", c.crys_uranium)
terumet.register_vulcan_result("technic:zinc_lump", c.crys_zinc)
