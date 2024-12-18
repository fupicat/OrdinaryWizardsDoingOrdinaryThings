extends Node2D

const NumberParticle = preload("res://scenes/components/number_particle/number_particle.tscn")


func particle(number: int) -> void:
    var np = NumberParticle.instantiate()
    np.number = number
    add_child(np)
