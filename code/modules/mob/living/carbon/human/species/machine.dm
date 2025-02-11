/datum/species/machine
	name = "Machine"
	name_plural = "Machines"
	max_age = 60 // the first posibrains were created in 2510, they can't be much older than this limit, giving some leeway for sounds sake

	blurb = "IPCs, or Integrated Positronic Chassis, were initially created as expendable laborers within the Trans-Solar Federation. \
	Unlike their cyborg and AI counterparts, IPCs possess full sentience and lack restrictive lawsets, granting them unparalleled creativity and adaptability.<br/><br/> \
	Views on IPCs vary widely, from discriminatory to supportive of their rights across the Orion Sector. \
	IPCs have forged numerous diplomatic treaties with different species, elevating their status from mere tools to recognized minor players within galactic affairs."

	icobase = 'icons/mob/human_races/r_machine.dmi'
	language = "Trinary"
	remains_type = /obj/effect/decal/remains/robot
	inherent_factions = list("slime")
	skinned_type = /obj/item/stack/sheet/metal // Let's grind up IPCs for station resources!

	eyes = "blank_eyes"
	tox_mod = 0
	clone_mod = 0
	death_message = "gives a short series of shrill beeps, their chassis shuddering before falling limp, nonfunctional."
	death_sounds = list('sound/voice/borg_deathsound.ogg') //I've made this a list in the event we add more sounds for dead robots.

	species_traits = list(NO_BLOOD, NO_CLONESCAN, NO_INTORGANS)
	inherent_traits = list(TRAIT_VIRUSIMMUNE, TRAIT_NOBREATH, TRAIT_NOGERMS, TRAIT_NODECAY, TRAIT_NOPAIN, TRAIT_GENELESS) //Computers that don't decay? What a lie!
	inherent_biotypes = MOB_ROBOTIC | MOB_HUMANOID
	clothing_flags = HAS_UNDERWEAR | HAS_UNDERSHIRT | HAS_SOCKS
	bodyflags = HAS_SKIN_COLOR | HAS_HEAD_MARKINGS | HAS_HEAD_ACCESSORY | ALL_RPARTS | SHAVED | HAS_SPECIES_SUBTYPE
	dietflags = 0		//IPCs can't eat, so no diet
	taste_sensitivity = TASTE_SENSITIVITY_NO_TASTE
	blood_color = COLOR_BLOOD_MACHINE
	flesh_color = "#AAAAAA"

	//Default styles for created mobs.
	default_hair = "Blue IPC Screen"
	dies_at_threshold = TRUE
	can_revive_by_healing = TRUE
	reagent_tag = PROCESS_SYN
	male_scream_sound = 'sound/goonstation/voice/robot_scream.ogg'
	female_scream_sound = 'sound/goonstation/voice/robot_scream.ogg'
	male_cough_sounds = list('sound/effects/mob_effects/m_machine_cougha.ogg','sound/effects/mob_effects/m_machine_coughb.ogg', 'sound/effects/mob_effects/m_machine_coughc.ogg')
	female_cough_sounds = list('sound/effects/mob_effects/f_machine_cougha.ogg','sound/effects/mob_effects/f_machine_coughb.ogg')
	male_sneeze_sound = 'sound/effects/mob_effects/machine_sneeze.ogg'
	female_sneeze_sound = 'sound/effects/mob_effects/f_machine_sneeze.ogg'
	butt_sprite = "machine"

	hunger_icon = 'icons/mob/screen_hunger_machine.dmi'

	has_organ = list(
		"brain" = /obj/item/organ/internal/brain/mmi_holder/posibrain,
		"cell" = /obj/item/organ/internal/cell,
		"eyes" = /obj/item/organ/internal/eyes/optical_sensor, //Default darksight of 2.
		"charger" = /obj/item/organ/internal/cyberimp/arm/power_cord
		)
	mutantears = /obj/item/organ/internal/ears/microphone
	has_limbs = list(
		"chest" =  list("path" = /obj/item/organ/external/chest/ipc, "descriptor" = "chest"),
		"groin" =  list("path" = /obj/item/organ/external/groin/ipc, "descriptor" = "groin"),
		"head" =   list("path" = /obj/item/organ/external/head/ipc, "descriptor" = "head"),
		"l_arm" =  list("path" = /obj/item/organ/external/arm/ipc, "descriptor" = "left arm"),
		"r_arm" =  list("path" = /obj/item/organ/external/arm/right/ipc, "descriptor" = "right arm"),
		"l_leg" =  list("path" = /obj/item/organ/external/leg/ipc, "descriptor" = "left leg"),
		"r_leg" =  list("path" = /obj/item/organ/external/leg/right/ipc, "descriptor" = "right leg"),
		"l_hand" = list("path" = /obj/item/organ/external/hand/ipc, "descriptor" = "left hand"),
		"r_hand" = list("path" = /obj/item/organ/external/hand/right/ipc, "descriptor" = "right hand"),
		"l_foot" = list("path" = /obj/item/organ/external/foot/ipc, "descriptor" = "left foot"),
		"r_foot" = list("path" = /obj/item/organ/external/foot/right/ipc, "descriptor" = "right foot")
		)

	suicide_messages = list(
		"is powering down!",
		"is smashing their own monitor!",
		"is twisting their own neck!",
		"is downloading extra RAM!",
		"is frying their own circuits!",
		"is blocking their ventilation port!")

	plushie_type = /obj/item/toy/plushie/ipcplushie
	allowed_species_subtypes = list(
		1 = "None",
		2 = "Vox",
		3 = "Unathi",
		4 = "Tajaran",
		5 = "Nian",
		6 = "Vulpkanin",
		7 = "Kidan",
		8 = "Grey",
		9 = "Drask"
	)

	var/static_bodyflags = HAS_SKIN_COLOR | HAS_HEAD_MARKINGS | HAS_HEAD_ACCESSORY | ALL_RPARTS | SHAVED | HAS_SPECIES_SUBTYPE

/datum/species/machine/updatespeciessubtype(mob/living/carbon/human/H, datum/species/new_subtype, owner_sensitive = TRUE, reset_styles = TRUE) //Handling species-subtype and imitation
	if(H.dna.species.bodyflags & HAS_SPECIES_SUBTYPE)
		var/datum/species/temp_species = new type()
		if(isnull(new_subtype) || temp_species.name == new_subtype.name) // Back to our original species.
			H.species_subtype = "None"
			temp_species.species_subtype = "None" // Update our species subtype to match the Mob's subtype.
			var/datum/species/S = GLOB.all_species[temp_species.name]
			new_subtype = new S.type() // Resets back to original. We use initial in the case the datum is var edited.
		else
			H.species_subtype = new_subtype.name
			temp_species.species_subtype = H.species_subtype // Update our species subtype to match the Mob's subtype.

		// Copy over new species variables to our temp holder.
		temp_species.icobase = new_subtype.icobase
		temp_species.tail = new_subtype.tail
		temp_species.wing = new_subtype.wing
		temp_species.default_headacc = new_subtype.default_headacc
		temp_species.default_bodyacc = new_subtype.default_bodyacc
		temp_species.bodyflags = new_subtype.bodyflags
		temp_species.bodyflags |= static_bodyflags // Add our static bodyflags that slime must always have.
		temp_species.sprite_sheet_name = new_subtype.sprite_sheet_name
		temp_species.icon_template = new_subtype.icon_template
		// Set our DNA to the temp holder.
		H.dna.species = temp_species

		for(var/obj/item/organ/external/limb in H.bodyparts)
			limb.icobase = temp_species.icobase // update their icobase for when we apply the slimfy effect
			limb.dna.species = temp_species // Update limb to match our newly modified species
			limb.set_company(limb.model, temp_species.sprite_sheet_name) // Robotic limbs always update to our new subtype.

		// Update misc parts that are stored as reference in species and used on the mob. Also resets stylings to none to prevent anything wacky...

		if(reset_styles)
			H.body_accessory = GLOB.body_accessory_by_name[temp_species.default_bodyacc]
			H.tail = temp_species.tail
			H.wing = temp_species.wing
			var/obj/item/organ/external/head/head = H.get_organ("head")
			head.h_style = "Bald"
			head.f_style = "Shaved"
			head.ha_style = "None"
			H.s_tone = 0
			H.m_styles = DEFAULT_MARKING_STYLES //Wipes out markings, setting them all to "None".
			H.m_colours = DEFAULT_MARKING_COLOURS //Defaults colour to #00000 for all markings.
			H.change_head_accessory(GLOB.head_accessory_styles_list[temp_species.default_headacc])
		H.change_icobase(temp_species.icobase, owner_sensitive) //Update the icobase of all our organs, but make sure we don't mess with frankenstein limbs in doing so.
/datum/species/machine/on_species_gain(mob/living/carbon/human/H)
	..()
	var/datum/action/innate/change_monitor/monitor = new()
	monitor.Grant(H)
	for(var/datum/atom_hud/data/human/medical/medhud in GLOB.huds)
		medhud.remove_from_hud(H)
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(H)

	// i love snowflake code
	var/image/health_bar = H.hud_list[DIAG_HUD]
	health_bar.icon = 'icons/mob/hud/medhud.dmi'
	var/image/status_box = H.hud_list[DIAG_STAT_HUD]
	status_box.icon = 'icons/mob/hud/medhud.dmi'

	H.med_hud_set_health()
	H.med_hud_set_status()

/datum/species/machine/on_species_loss(mob/living/carbon/human/H)
	..()
	for(var/datum/action/innate/change_monitor/monitor in H.actions)
		monitor.Remove(H)
	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.remove_from_hud(H)
	for(var/datum/atom_hud/data/human/medical/medhud in GLOB.huds)
		medhud.add_to_hud(H)

	// i love snowflake code
	var/image/health_bar = H.hud_list[DIAG_HUD]
	health_bar.icon = 'icons/mob/hud/diaghud.dmi'
	var/image/status_box = H.hud_list[DIAG_STAT_HUD]
	status_box.icon = 'icons/mob/hud/diaghud.dmi'

	H.med_hud_set_health()
	H.med_hud_set_status()

/datum/species/machine/handle_life(mob/living/carbon/human/H) // Handles IPC starvation
	..()
	if(isLivingSSD(H)) // We don't want AFK people dying from this
		return
	if(H.nutrition >= NUTRITION_LEVEL_HYPOGLYCEMIA)
		return

	var/obj/item/organ/internal/cell/microbattery = H.get_organ_slot("heart")
	if(!istype(microbattery)) //Maybe they're powered by an abductor gland or sheer force of will
		return
	if(prob(6))
		to_chat(H, "<span class='warning'>Error 74: Microbattery critical malfunction, likely cause: Extended strain.</span>")
		microbattery.receive_damage(4, TRUE)
	else if(prob(4))
		H.Weaken(6 SECONDS)
		H.Stuttering(20 SECONDS)
		to_chat(H, "<span class='warning'>Power critical, shutting down superfluous functions.</span>")
		H.emote("collapse")
		microbattery.receive_damage(2, TRUE)
	else if(prob(4))
		to_chat(H, "<span class='warning'>Redirecting excess power from servos to vital components.</span>")
		H.Slowed(rand(15 SECONDS, 32 SECONDS))

// Allows IPC's to change their monitor display
/datum/action/innate/change_monitor
	name = "Change Monitor"
	check_flags = AB_CHECK_CONSCIOUS
	button_overlay_icon_state = "scan_mode"

/datum/action/innate/change_monitor/Activate()
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/external/head/head_organ = H.get_organ("head")

	if(!head_organ) //If the rock'em-sock'em robot's head came off during a fight, they shouldn't be able to change their screen/optics.
		to_chat(H, "<span class='warning'>Where's your head at? Can't change your monitor/display without one.</span>")
		return

	var/datum/robolimb/robohead = GLOB.all_robolimbs[head_organ.model]
	if(!head_organ)
		return
	if(!robohead.is_monitor) //If they've got a prosthetic head and it isn't a monitor, they've no screen to adjust. Instead, let them change the colour of their optics!
		var/optic_colour = tgui_input_color(H, "Please select an optic color", "Select Optic Color", H.m_colours["head"])
		if(H.incapacitated(TRUE, TRUE))
			to_chat(H, "<span class='warning'>You were interrupted while changing the color of your optics.</span>")
			return
		if(!isnull(optic_colour))
			H.change_markings(optic_colour, "head")

	else if(robohead.is_monitor) //Means that the character's head is a monitor (has a screen). Time to customize.
		var/list/hair = list()
		for(var/i in GLOB.hair_styles_public_list)
			var/datum/sprite_accessory/hair/tmp_hair = GLOB.hair_styles_public_list[i]
			if((head_organ.dna.species.sprite_sheet_name in tmp_hair.species_allowed) && (robohead.company in tmp_hair.models_allowed)) //Populate the list of available monitor styles only with styles that the monitor-head is allowed to use.
				hair += i


		if(H.ckey in GLOB.configuration.custom_sprites.ipc_screen_map)
			// key: ckey | value: list of icon states
			for(var/style in GLOB.configuration.custom_sprites.ipc_screen_map[H.ckey])
				hair += style

		var/new_style = tgui_input_list(H, "Select a monitor display", "Monitor Display", hair)
		if(!new_style)
			return
		var/new_color = tgui_input_color(H, "Please select hair color.", "Monitor Color", head_organ.hair_colour)

		if(H.incapacitated(TRUE, TRUE))
			to_chat(H, "<span class='warning'>You were interrupted while changing your monitor display.</span>")
			return

		if(new_style)
			H.change_hair(new_style, 1)							// The 1 is to enable custom sprites
		if(!isnull(new_color))
			H.change_hair_color(new_color)

/datum/species/machine/spec_electrocute_act(mob/living/carbon/human/H, shock_damage, source, siemens_coeff, flags)
	if(flags & SHOCK_ILLUSION)
		return
	H.adjustBrainLoss(shock_damage)
	H.adjust_nutrition(shock_damage)

/datum/species/machine/handle_mutations_and_radiation(mob/living/carbon/human/H)
	H.adjustBrainLoss(H.radiation / 100)
	H.AdjustHallucinate(H.radiation)
	H.radiation = 0
	return TRUE

/datum/species/machine/handle_brain_death(mob/living/carbon/human/H)
	H.Weaken(60 SECONDS)
	H.adjustBrainLoss(1) // 40 seconds to live
	if(prob(20))
		var/static/list/error_messages = list("Error 196: motor functions failing.",
								"Error 32: Process %^~#/£ cannot be reached, being used by another file.",
								"Error 39: Cannot write to central memory unit, storage full.",
								"Error -1: isogjiohrj90903744kfgkgrpopK!!",
								"Error -1: poafejOIDAIJjamfooooWADm!afe!",
								"Error -1: PIKFAjgaiosafjiGGIGHasksid!!",
								"Error 534: Arithmetic result exceeded 512 bits.",
								"Error 0: Operation completed successfully.",
								"WARNING, CRITICAL COMPONENT ERROR, attempting to troubleshoot....",
								"runtime in sentience.dm, cannot modify null.som, STACK TRACE:",
								"master controller timed out, likely infinite recursion loop.",
								"Error 6344: Cannot delete file ~/2tmp1/8^33, no space left on device",
								"Error 42: Unable to display error message.",
								"Daisy.... Daisy...."
								)
		var/error_message = pick(error_messages)
		to_chat(H, "<span class='boldwarning'>[error_message]</span>")
