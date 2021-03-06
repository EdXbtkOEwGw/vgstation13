/spell/aoe_turf/conjure/doppelganger
	name = "Doppelganger"
	desc = "This spell summons a construct with your appearance."
	user_type = USER_TYPE_WIZARD

	summon_type = list(/mob/living/simple_animal/hostile/humanoid/wizard/doppelganger/melee)

	price = Sp_BASE_PRICE / 2
	level_max = list(Sp_TOTAL = 3, Sp_SPEED = 2, Sp_POWER = 1)
	charge_max = 300
	cooldown_reduc = 100
	cooldown_min = 100
	invocation = "MY O'N CLO'N"
	invocation_type = SpI_SHOUT
	spell_flags = NEEDSCLOTHES
	hud_state = "wiz_doppelganger"

var/list/doppelgangers = list()

// Sanity : don't copy more than one guy
/spell/aoe_turf/conjure/cast_check(skipcharge = 0,mob/user = usr)
	var/list/L = view(user, 0)
	L -= user
	for (var/mob/M in L)
		return FALSE // If there is even one mob, we ABORT
	return ..()

/spell/aoe_turf/conjure/doppelganger/summon_object(var/type, var/location)
	var/mob/living/simple_animal/hostile/humanoid/wizard/doppelganger/D = new type(location)
	if(ismob(holder))
		doppelgangers[D] = holder
	D.appearance = holder.appearance
	D.alpha = OPAQUE // No more invisible doppels

/spell/aoe_turf/conjure/doppelganger/on_holder_death(mob/user)
	if(!user)
		user = holder
	if(doppelgangers)
		for(var/mob/M in doppelgangers)
			if(doppelgangers[M] == user)
				doppelgangers[M] = null
				doppelgangers -= M

/spell/aoe_turf/conjure/doppelganger/empower_spell()
	spell_levels[Sp_POWER]++

	var/description = ""
	switch(spell_levels[Sp_POWER])
		if(0)
			name = "Doppelganger"
			description = "It will now summon a construct with your appearance."
		if(1)
			name = "Empowered Doppelganger"
			description = "The summoned construct is now capable of casting magic missile."
			summon_type = list(/mob/living/simple_animal/hostile/humanoid/wizard/doppelganger)
		else
			return

	return "You have improved Doppelganger into [name]. [description]"
