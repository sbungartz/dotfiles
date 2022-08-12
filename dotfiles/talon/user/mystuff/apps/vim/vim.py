from talon import Context, Module
import re

ctx = Context = Context()

mod = Module()
mod.apps.vim = """
tag: terminal
title: / - VIM$/
"""

ctx.matches = """
app: vim
"""

@ctx.action_class("win")
class WinActions:
    def filename():
        title = actions.when.title()
        
        match = re.search(r"(.*) (+ )?\(.*) - VIM$")

