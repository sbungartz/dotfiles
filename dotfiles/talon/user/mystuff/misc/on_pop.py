from talon import noise, actions

def on_pop(active):
    actions.user.mouse_on_pop()

noise.register("pop", on_pop)
