def describe_pet(pet_name, animal_type="dog"):
    return f"{pet_name} is a {animal_type}"

print(describe_pet(pet_name="Buddy"))
print(describe_pet(animal_type="cat", pet_name="Whiskers"))
