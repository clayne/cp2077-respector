local mod = ...

local perks = mod and mod.load('mod/data/perks')

local function specTimestamp()
	return os.date('%d.%m.%Y %H:%M:%S')
end

local function percDescription(_, node)
	if perks then
		local perk = perks[node.name]
		
		return ('Max: %s / %s'):format(perk.trait and '0+' or perk.max, perk.desc)
	end
end

return {
	comment = specTimestamp,
	children = {
		{
			name = "Character",
			children = {
				{ name = "Level" },
				{ name = "StreetCred" },
				{
					name = "Attributes",
					margin = true,
					children = {
						{ name = "Body" },
						{ name = "Reflexes" },
						{ name = "TechnicalAbility" },
						{ name = "Intelligence" },
						{ name = "Cool" },
					},
				},
				{
					name = "Skills",
					margin = true,
					children = {
						{ name = "Athletics" },
						{ name = "Annihilation" },
						{ name = "StreetBrawler" },
						{ name = "Assault" },
						{ name = "Handguns" },
						{ name = "Blades" },
						{ name = "Crafting" },
						{ name = "Engineering" },
						{ name = "BreachProtocol" },
						{ name = "Quickhacking" },
						{ name = "Stealth" },
						{ name = "ColdBlood" },
					},
				},
				{
					name = "Perks",
					margin = true,
					children = {
						{
							name = "Athletics",
							scope = "Perks",
							children = {
								{ name = "Regeneration", comment = percDescription },
								{ name = "PackMule", comment = percDescription },
								{ name = "Invincible", comment = percDescription },
								{ name = "TrueGrit", comment = percDescription },
								{ name = "Epimorphosis", comment = percDescription },
								{ name = "SoftOnYourFeet", comment = percDescription },
								{ name = "SteelAndChrome", comment = percDescription },
								{ name = "Gladiator", comment = percDescription },
								{ name = "DividedAttention", comment = percDescription },
								{ name = "Multitasker", comment = percDescription },
								{ name = "LikeAButterfly", comment = percDescription },
								{ name = "Transporter", comment = percDescription },
								{ name = "StrongerTogether", comment = percDescription },
								{ name = "CardioCure", comment = percDescription },
								{ name = "HumanShield", comment = percDescription },
								{ name = "Marathoner", comment = percDescription },
								{ name = "DogOfWar", comment = percDescription },
								{ name = "Wolverine", comment = percDescription },
								{ name = "SteelShell", comment = percDescription },
								{ name = "TheRock", comment = percDescription },
								{ name = "Indestructible", comment = percDescription },
								{ name = "HardMotherfucker", comment = percDescription },
							},
						},
						{
							name = "Annihilation",
							scope = "Perks",
							children = {
								{ name = "HailOfBullets", comment = percDescription },
								{ name = "PumpItLouder", comment = percDescription },
								{ name = "InYourFace", comment = percDescription },
								{ name = "Bloodrush", comment = percDescription },
								{ name = "DeadCenter", comment = percDescription },
								{ name = "Bulldozer", comment = percDescription },
								{ name = "Mongoose", comment = percDescription },
								{ name = "MomentumShift", comment = percDescription },
								{ name = "Massacre", comment = percDescription },
								{ name = "SkeetShooter", comment = percDescription },
								{ name = "HeavyLead", comment = percDescription },
								{ name = "Unstoppable", comment = percDescription },
								{ name = "Manic", comment = percDescription },
								{ name = "SpeedDemon", comment = percDescription },
								{ name = "BurnBabyBurn", comment = percDescription },
								{ name = "HitTheDeck", comment = percDescription },
								{ name = "PoppinOff", comment = percDescription },
								{ name = "Biathlete", comment = percDescription },
								{ name = "Bloodbath", comment = percDescription },
							},
						},
						{
							name = "StreetBrawler",
							scope = "Perks",
							children = {
								{ name = "Flurry", comment = percDescription },
								{ name = "CrushingBlows", comment = percDescription },
								{ name = "Juggernaut", comment = percDescription },
								{ name = "Dazed", comment = percDescription },
								{ name = "Rush", comment = percDescription },
								{ name = "EfficientBlows", comment = percDescription },
								{ name = "HumanFortress", comment = percDescription },
								{ name = "OpportuneStrike", comment = percDescription },
								{ name = "Payback", comment = percDescription },
								{ name = "Reinvigorate", comment = percDescription },
								{ name = "BreathingSpace", comment = percDescription },
								{ name = "Relentless", comment = percDescription },
								{ name = "Frenzy", comment = percDescription },
								{ name = "Thrash", comment = percDescription },
								{ name = "BidingTime", comment = percDescription },
								{ name = "Unshakeable", comment = percDescription },
								{ name = "Guerrilla", comment = percDescription },
							},
						},
						{
							name = "Assault",
							scope = "Perks",
							children = {
								{ name = "Bulletjock", comment = percDescription },
								{ name = "EagleEye", comment = percDescription },
								{ name = "CoveringKillshot", comment = percDescription },
								{ name = "TooCloseForComfort", comment = percDescription },
								{ name = "Bullseye", comment = percDescription },
								{ name = "Executioner", comment = percDescription },
								{ name = "ShootReloadRepeat", comment = percDescription },
								{ name = "DuckHunter", comment = percDescription },
								{ name = "NervesOfSteel", comment = percDescription },
								{ name = "FeelTheFlow", comment = percDescription },
								{ name = "TrenchWarfare", comment = percDescription },
								{ name = "HuntersHands", comment = percDescription },
								{ name = "SkullSkipper", comment = percDescription },
								{ name = "NamedBullets", comment = percDescription },
								{ name = "Bunker", comment = percDescription },
								{ name = "RecoilWrangler", comment = percDescription },
								{ name = "InPerspective", comment = percDescription },
								{ name = "LongShot", comment = percDescription },
								{ name = "SavageStoic", comment = percDescription },
								{ name = "Punisher", comment = percDescription },
							},
						},
						{
							name = "Handguns",
							scope = "Perks",
							children = {
								{ name = "Gunslinger", comment = percDescription },
								{ name = "HighNoon", comment = percDescription },
								{ name = "RioBravo", comment = percDescription },
								{ name = "Desperado", comment = percDescription },
								{ name = "OnTheFly", comment = percDescription },
								{ name = "LongShotDropPop", comment = percDescription },
								{ name = "SteadyHand", comment = percDescription },
								{ name = "OKCorral", comment = percDescription },
								{ name = "VanishingPoint", comment = percDescription },
								{ name = "AFistfulOfEurdollars", comment = percDescription },
								{ name = "FromHeadToToe", comment = percDescription },
								{ name = "GrandFinale", comment = percDescription },
								{ name = "Acrobat", comment = percDescription },
								{ name = "AttritionalFire", comment = percDescription },
								{ name = "WildWest", comment = percDescription },
								{ name = "SnowballEffect", comment = percDescription },
								{ name = "Westworld", comment = percDescription },
								{ name = "LeadSponge", comment = percDescription },
								{ name = "Brainpower", comment = percDescription },
								{ name = "TheGoodTheBadAndTheUgly", comment = percDescription },
							},
						},
						{
							name = "Blades",
							scope = "Perks",
							children = {
								{ name = "StingLikeABee", comment = percDescription },
								{ name = "RoaringWaters", comment = percDescription },
								{ name = "CrimsonDance", comment = percDescription },
								{ name = "SlowAndSteady", comment = percDescription },
								{ name = "FlightOfTheSparrow", comment = percDescription },
								{ name = "OffensiveDefense", comment = percDescription },
								{ name = "StuckPig", comment = percDescription },
								{ name = "ShiftingSands", comment = percDescription },
								{ name = "BlessedBlade", comment = percDescription },
								{ name = "UnbrokenSpirit", comment = percDescription },
								{ name = "Bloodlust", comment = percDescription },
								{ name = "FloatLikeAButterfly", comment = percDescription },
								{ name = "FieryBlast", comment = percDescription },
								{ name = "JudgeJuryAndExecutioner", comment = percDescription },
								{ name = "CrimsonTide", comment = percDescription },
								{ name = "Deathbolt", comment = percDescription },
								{ name = "DragonStrike", comment = percDescription },
							},
						},
						{
							name = "Crafting",
							scope = "Perks",
							children = {
								{ name = "Mechanic", comment = percDescription },
								{ name = "TrueCraftsman", comment = percDescription },
								{ name = "Scrapper", comment = percDescription },
								{ name = "Workshop", comment = percDescription },
								{ name = "Innovation", comment = percDescription },
								{ name = "Sapper", comment = percDescription },
								{ name = "FieldTechnician", comment = percDescription },
								{ name = "TwoHundredEfficiency", comment = percDescription },
								{ name = "ExNihilo", comment = percDescription },
								{ name = "EfficientUpgradesc", comment = percDescription },
								{ name = "GreaseMonkey", comment = percDescription },
								{ name = "CostOptimization", comment = percDescription },
								{ name = "LetThereBeLight", comment = percDescription },
								{ name = "WasteNotWantNot", comment = percDescription },
								{ name = "TuneUp", comment = percDescription },
								{ name = "EdgerunnerArtisan", comment = percDescription },
								{ name = "CuttingEdge", comment = percDescription },
								{ name = "CrazyScience", comment = percDescription },
							},
						},
						{
							name = "Engineering",
							scope = "Perks",
							children = {
								{ name = "MechLooter", comment = percDescription },
								{ name = "BlastShielding", comment = percDescription },
								{ name = "CantTouchThis", comment = percDescription },
								{ name = "Grenadier", comment = percDescription },
								{ name = "Shrapnel", comment = percDescription },
								{ name = "Bladerunner", comment = percDescription },
								{ name = "UpTo11", comment = percDescription },
								{ name = "LockAndload", comment = percDescription },
								{ name = "BiggerBooms", comment = percDescription },
								{ name = "Tesla", comment = percDescription },
								{ name = "LightingBolt", comment = percDescription },
								{ name = "GunWhisperer", comment = percDescription },
								{ name = "Ubercharge", comment = percDescription },
								{ name = "Insulation", comment = percDescription },
								{ name = "FuckAllWalls", comment = percDescription },
								{ name = "PlayTheAngles", comment = percDescription },
								{ name = "LicketySplit", comment = percDescription },
								{ name = "Jackpot", comment = percDescription },
								{ name = "Superconductor", comment = percDescription },
								{ name = "Revamp", comment = percDescription },
							},
						},
						{
							name = "BreachProtocol",
							scope = "Perks",
							children = {
								{ name = "BigSleep", comment = percDescription },
								{ name = "MassVulnerability", comment = percDescription },
								{ name = "AlmostIn", comment = percDescription },
								{ name = "AdvancedDatamine", comment = percDescription },
								{ name = "MassVulnerabilityResistances", comment = percDescription },
								{ name = "ExtendedNetworkInterface", comment = percDescription },
								{ name = "TurretShutdown", comment = percDescription },
								{ name = "DatamineMastermind", comment = percDescription },
								{ name = "TotalRecall", comment = percDescription },
								{ name = "DatamineVirtuoso", comment = percDescription },
								{ name = "TurretTamer", comment = percDescription },
								{ name = "Efficiency", comment = percDescription },
								{ name = "CloudCache", comment = percDescription },
								{ name = "MassVulnerabilityQuickhacks", comment = percDescription },
								{ name = "TotalerRecall", comment = percDescription },
								{ name = "Hackathon", comment = percDescription },
								{ name = "HeadStart", comment = percDescription },
								{ name = "Compression", comment = percDescription },
								{ name = "BufferOptimization", comment = percDescription },
								{ name = "Transmigration", comment = percDescription },
							},
						},
						{
							name = "Quickhacking",
							scope = "Perks",
							children = {
								{ name = "Biosynergy", comment = percDescription },
								{ name = "Bloodware", comment = percDescription },
								{ name = "ForgetMeNot", comment = percDescription },
								{ name = "ISpy", comment = percDescription },
								{ name = "HackersManual", comment = percDescription },
								{ name = "DaisyChain", comment = percDescription },
								{ name = "WeakLink", comment = percDescription },
								{ name = "SignalSupport", comment = percDescription },
								{ name = "SubliminalMessage", comment = percDescription },
								{ name = "Mnemonic", comment = percDescription },
								{ name = "Diffusion", comment = percDescription },
								{ name = "SchoolOfHardHacks", comment = percDescription },
								{ name = "Plague", comment = percDescription },
								{ name = "CriticalError", comment = percDescription },
								{ name = "HackerOverlord", comment = percDescription },
								{ name = "Anamnesis", comment = percDescription },
								{ name = "Optimization", comment = percDescription },
								{ name = "BartmossLegacy", comment = percDescription },
								{ name = "MasterRAMLiberator", comment = percDescription },
							},
						},
						{
							name = "Stealth",
							scope = "Perks",
							children = {
								{ name = "SilentAndDeadly", comment = percDescription },
								{ name = "CrouchingTiger", comment = percDescription },
								{ name = "HiddenDragon", comment = percDescription },
								{ name = "DaggerDealer", comment = percDescription },
								{ name = "StrikeFromTheShadows", comment = percDescription },
								{ name = "Assassin", comment = percDescription },
								{ name = "Sniper", comment = percDescription },
								{ name = "Cutthroat", comment = percDescription },
								{ name = "LegUp", comment = percDescription },
								{ name = "CleanWork", comment = percDescription },
								{ name = "AggressiveAntitoxins", comment = percDescription },
								{ name = "StunningBlows", comment = percDescription },
								{ name = "Ghost", comment = percDescription },
								{ name = "FromTheShadows", comment = percDescription },
								{ name = "Commando", comment = percDescription },
								{ name = "Rattlesnake", comment = percDescription },
								{ name = "VenomousFangs", comment = percDescription },
								{ name = "RestorativeShadows", comment = percDescription },
								{ name = "HastyRetreat", comment = percDescription },
								{ name = "SilentFinisher", comment = percDescription },
								{ name = "Neurotoxin", comment = percDescription },
								{ name = "CheatDeath", comment = percDescription },
								{ name = "HastenTheInevitable", comment = percDescription },
								{ name = "Ninjutsu", comment = percDescription },
								{ name = "Toxicology", comment = percDescription },
							},
						},
						{
							name = "ColdBlood",
							scope = "Perks",
							children = {
								{ name = "ColdBlood", comment = percDescription },
								{ name = "WillToSurvive", comment = percDescription },
								{ name = "IcyVeins", comment = percDescription },
								{ name = "CriticalCondition", comment = percDescription },
								{ name = "FrostySynapses", comment = percDescription },
								{ name = "DefensiveClotting", comment = percDescription },
								{ name = "RapidBloodflow", comment = percDescription },
								{ name = "ColdestBlood", comment = percDescription },
								{ name = "FrozenPrecision", comment = percDescription },
								{ name = "Predator", comment = percDescription },
								{ name = "BloodBrawl", comment = percDescription },
								{ name = "QuickTransfer", comment = percDescription },
								{ name = "Bloodswell", comment = percDescription },
								{ name = "ColdAndCalculating", comment = percDescription },
								{ name = "Coolagulant", comment = percDescription },
								{ name = "Unbreakable", comment = percDescription },
								{ name = "PainIsAnIllusion", comment = percDescription },
								{ name = "Immunity", comment = percDescription },
								{ name = "Merciless", comment = percDescription },
							},
						},
					},
				},
				{
					name = "Progression",
					scope = "Progression",
					margin = true,
					children = {
						{ name = "Athletics" },
						{ name = "Annihilation" },
						{ name = "StreetBrawler" },
						{ name = "Assault" },
						{ name = "Handguns" },
						{ name = "Blades" },
						{ name = "Crafting" },
						{ name = "Engineering" },
						{ name = "BreachProtocol" },
						{ name = "Quickhacking" },
						{ name = "Stealth" },
						{ name = "ColdBlood" },
					},
				},
				{
					name = "Points",
					scope = "Points",
					margin = true,
					children = {
						{ name = "Attribute" },
						{ name = "Perk" },
					},
				},
			},
		},
		{
			name = "Inventory",
			margin = true,
			spacing = true,
			table = {
				{
					name = "id",
					inline = true,
					children = {
						{ name = "hash", format = "0x%08X" },
						{ name = "length" }
					}
				},
				{ name = "seed" },
				{ name = "upgrade" },
				{
					name = "slots",
					table = {
						{ name = "slot" },
						{
							name = "id",
							inline = true,
							children = {
								{ name = "hash", format = "0x%08X" },
								{ name = "length" }
							}
						},
						{ name = "seed" },
						{ name = "upgrade" },
					}
				},
				{ name = "equip" },
				{ name = "quest" },
				{ name = "qty" },
			}
		},
		{
			name = "Crafting",
			margin = true,
			children = {
				{
					name = "Components",
					children = {
						{ name = "CommonItem" },
						{ name = "UncommonItem" },
						{ name = "RareItem" },
						{ name = "RareUpgrade" },
						{ name = "EpicItem" },
						{ name = "EpicUpgrade" },
						{ name = "LegendaryItem" },
						{ name = "LegendaryUpgrade" },
						{ name = "UncommonQuickhack" },
						{ name = "RareQuickhack" },
						{ name = "EpicQuickhack" },
						{ name = "LegenaryQuickhack" },
					}
				},
				{
					name = "Recipes",
					format = {
						number = "0x%010X"
					}
				},
			},
		},
		{
			name = "Transport",
			margin = true,
		},
	}
}