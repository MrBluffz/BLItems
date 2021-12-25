--[[
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──────────██████─████████████████──────██████████████───██████─────────██████──██████─██████████████─██████████████─██████████████████─
─██░░██████████████░░██─██░░░░░░░░░░░░██──────██░░░░░░░░░░██───██░░██─────────██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─
─██░░░░░░░░░░░░░░░░░░██─██░░████████░░██──────██░░██████░░██───██░░██─────────██░░██──██░░██─██░░██████████─██░░██████████─████████████░░░░██─
─██░░██████░░██████░░██─██░░██────██░░██──────██░░██──██░░██───██░░██─────────██░░██──██░░██─██░░██─────────██░░██─────────────────████░░████─
─██░░██──██░░██──██░░██─██░░████████░░██──────██░░██████░░████─██░░██─────────██░░██──██░░██─██░░██████████─██░░██████████───────████░░████───
─██░░██──██░░██──██░░██─██░░░░░░░░░░░░██──────██░░░░░░░░░░░░██─██░░██─────────██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─────████░░████─────
─██░░██──██████──██░░██─██░░██████░░████──────██░░████████░░██─██░░██─────────██░░██──██░░██─██░░██████████─██░░██████████───████░░████───────
─██░░██──────────██░░██─██░░██──██░░██────────██░░██────██░░██─██░░██─────────██░░██──██░░██─██░░██─────────██░░██─────────████░░████─────────
─██░░██──────────██░░██─██░░██──██░░██████────██░░████████░░██─██░░██████████─██░░██████░░██─██░░██─────────██░░██─────────██░░░░████████████─
─██░░██──────────██░░██─██░░██──██░░░░░░██────██░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██─────────██░░██─────────██░░░░░░░░░░░░░░██─
─██████──────────██████─██████──██████████────████████████████─██████████████─██████████████─██████─────────██████─────────██████████████████─
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 
]] 

-- ####################################################################################
-- #                                   DISCORD:                                       #
-- #                          https://discord.gg/QPPSBncbZn                           #
-- ####################################################################################

Config = {}
-- DO NOT TOUCH ABOVE
-- DO NOT TOUCH ABOVE

Config.Notification = { -- [ 'chat' | 'ns' | 'mythic_old' | 'mythic_new' | 'esx' | 'custom' ].
	server = 'esx',
}

Config.Locale = "en" -- Locale is only in english for now. Make your own Locale file, then change the name here. Share any custom Locale files with me so I can update the main repository!


Config.ItemNames = {
	{
		name = 'meth',
		Lsize = 10,
	}, -- name needs to be the database item you want to use to create something
	{
		name = 'cocaine',
		Lsize = 10,
	}, -- Lsize is how many of the item should you have in your inventory to create the "large" version
}

Config.Items = { -- List all items here, follow the template.
	['meth'] = { -- This should match the 'name' from above
		['small'] = { -- We split into two sizes, small and large. small is using 1 drug item. 1 'meth' = 1 final product
			['drugscales'] = { -- db item name
				count = 1, -- [ number ]   script checks to make sure you have this many, then removes it.
				keep = false, -- [ false | true ] Do you want to keep this item? false = use the item | true = keep item
			},
			['dopebag'] = {
				count = 1,
				keep = false,
			},
			['final'] = { -- This is the final product. The db item name goes below
				name = 'bagofmeth', -- Right here. This is db item name
				count = 1, -- How many do you wish to receive? 
			},
		},
		['large'] = { -- large is using whatever Lsize is in ItemNames. So with default, 10 "meth" would make 1 large item
			['dopebagbig'] = {
				count = 1,
				keep = false,
			},
			['drugsscaleslarge'] = {
				count = 1,
				keep = false,
			},
			['foodsaver'] = {
				count = 1,
				keep = true,
			},
			['final'] = {
				name = 'methbrick',
				count = 1,
			},
		},
	},
	['cocaine'] = {
		['small'] = {
			['drugscales'] = {
				count = 1,
				keep = false,
			},
			['dopebag'] = {
				count = 1,
				keep = false,
			},
			['final'] = {
				name = 'bagofcoke',
				count = 1,
			},
		},
		['large'] = {
			['dopebagbig'] = {
				count = 1,
				keep = false,
			},
			['drugsscaleslarge'] = {
				count = 1,
				keep = false,
			},
			['foodsaver'] = {
				count = 1,
				keep = true,
			},
			['final'] = {
				name = 'cokebrick',
				count = 1,
			},
		},
	},
	--[[
	['useableitemhere'] = {
		['small'] = {
			['requireditem'] = {
				count = 1,
				keep = false,
			},
			['requireditem'] = {
				count = 1,
				keep = false,
			},
			['final'] = {
				name = 'finalproducthere',
				count = 1,
			},
		},
		['large'] = {
			['requireditem'] = {
				count = 1,
				keep = false,
			},
			['requireditem'] = {
				count = 1,
				keep = false,
			},
			['requireditem'] = {
				count = 1,
				keep = true,
			},
			['final'] = {
				name = 'finalproducthere',
				count = 1,
			},
		},
	},
]]
}
