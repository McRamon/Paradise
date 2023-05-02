//Wrench
/obj/item/wrench
	name = "wrench"
	desc = "A wrench with common uses. Can be found in your hand."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench"
	belt_icon = "wrench"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 5
	throwforce = 7
	usesound = 'sound/items/ratchet.ogg'
	w_class = WEIGHT_CLASS_SMALL
	materials = list(MAT_METAL = 600)
	drop_sound = 'sound/items/handling/wrench_drop.ogg'
	pickup_sound =  'sound/items/handling/wrench_pickup.ogg'
	origin_tech = "materials=1;engineering=1"
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	toolspeed = 1
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 30)
	tool_behaviour = TOOL_WRENCH

/obj/item/wrench/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is beating [user.p_themselves()] to death with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/weapons/genhit.ogg', 50, 1, -1)
	return BRUTELOSS

/obj/item/wrench/cyborg
	name = "automatic wrench"
	desc = "An advanced robotic wrench. Can be found in construction cyborgs."
	toolspeed = 0.5

/obj/item/wrench/brass
	name = "brass wrench"
	desc = "A brass wrench. It's faintly warm to the touch."
	icon_state = "wrench_brass"
	toolspeed = 0.5
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/wrench/abductor
	name = "alien wrench"
	desc = "A polarized wrench. It causes anything placed between the jaws to turn."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "wrench"
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.1
	origin_tech = "materials=5;engineering=5;abductor=3"

/obj/item/wrench/power
	name = "hand drill"
	desc = "A simple powered drill with a bolt bit."
	icon_state = "drill_bolt"
	item_state = "drill"
	belt_icon = "hand_drill"
	usesound = 'sound/items/drill_use.ogg'
	materials = list(MAT_METAL=150,MAT_SILVER=50,MAT_TITANIUM=25)
	origin_tech = "materials=2;engineering=2" //done for balance reasons, making them high value for research, but harder to get
	force = 8 //might or might not be too high, subject to change
	throwforce = 8
	attack_verb = list("drilled", "screwed", "jabbed")
	toolspeed = 0.25
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/wrench/power/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg', 50, 1)
	var/obj/item/wirecutters/power/s_drill = new /obj/item/screwdriver/power
	to_chat(user, "<span class='notice'>You attach the screwdriver bit to [src].</span>")
	qdel(src)
	user.put_in_active_hand(s_drill)

/obj/item/wrench/power/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is pressing [src] against [user.p_their()] head! It looks like [user.p_theyre()] trying to commit suicide!")
	return BRUTELOSS

/obj/item/wrench/medical
	name = "medical wrench"
	desc = "A medical wrench with common (medical?) uses. Can be found in your hand."
	icon_state = "wrench_medical"
	force = 2 //MEDICAL
	throwforce = 4
	origin_tech = "materials=1;engineering=1;biotech=3"
	attack_verb = list("wrenched", "medicaled", "tapped", "jabbed", "whacked")

/obj/item/wrench/medical/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is praying to the medical wrench to take [user.p_their()] soul. It looks like [user.p_theyre()] trying to commit suicide!</span>")
	// HAVE THEM GLOW WITH THE BRIGHTNESS OF A THOUSAND SUNS
	user.set_light(10, 25, rgb(255, 252, 82))

	var/previous_color = user.color

	user.color = rgb(255, 252, 82)

	// thank you vi3
	user.add_filter("sacrifice_glow", 2, list("type" = "outline", "color" = "#55dcfdd2", "size" = 2))
	var/filter = user.get_filter("sacrifice_glow")
	// Pulse in and out
	animate(filter, alpha = 110, time = 3, loop = -1)
	animate(alpha = 40, time = 6)

	// Stun stops them from wandering off
	user.Stun(10 SECONDS)
	playsound(loc, 'sound/effects/pray.ogg', 50, 1, -1)

	// Let the sound effect finish playing
	sleep(20)

	if(!user)
		return

	for(var/obj/item/W in user)
		user.unEquip(W)

	for(var/mob/living/M in orange(2, src))
		// you're close enough, it's pretty fuckin bright
		M.flash_eyes(1, TRUE, TRUE)

	var/obj/item/wrench/medical/W = new /obj/item/wrench/medical(loc)
	W.add_fingerprint(user)
	W.desc += " For some reason, it reminds you of [user.name]."

	if(!user)
		return

	user.color = previous_color  // for the sake of their ghost

	user.dust()
	user.visible_message("<span class='suicide'>[user]'s soul coalesces into a new [W.name]!</span>")
	return OBLITERATION
