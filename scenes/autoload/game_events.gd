extends Node

signal experience_vial_collected(number: float)
signal ability_upgraes_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


func emit_experience_vial_collected(number: float):
	experience_vial_collected.emit(number)
	
	
func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgraes_added.emit(upgrade, current_upgrades)
