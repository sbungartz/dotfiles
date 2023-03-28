from talon import noise, actions, cron

cron_job = None


def on_hiss(active: bool):
    global cron_job
    if actions.speech.enabled():
        if active:
            cron_job = cron.after("100ms", mouse_scrolling)
        else:
            cron.cancel(cron_job)
            actions.user.mouse_scroll_stop()


def mouse_scrolling():
    actions.user.mouse_scroll_down_continuous()

noise.register("hiss", on_hiss)
