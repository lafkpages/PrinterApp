#!/usr/bin/python3

'''
Printer App for connecting to printers, checking ink levels, scanning, etc.
'''

import tkinter as tk
import re

ip = None

ipRegex = re.compile(r'(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}')

def connect(e=None):
  global ip, ipInput

  ip = ipInput.get().strip()

  if not ip:
    return

  ipMatch = ipRegex.match(ip)

  if not ipMatch:
    return

  ipWin.destroy()

  print('Got IP:', ip)

win = tk.Tk()
win.wm_title('Printer App')

ipWin = tk.Toplevel(win)
ipWin.wm_title('Printer IP Address')

win.after(1, lambda: win.focus_force())
ipWin.after(100, lambda: ipWin.focus_force())

ipForm = tk.Frame(ipWin)
ipLabel = tk.Label(ipForm, text='Enter the printer\'s IP address:')
ipInput = tk.Entry(ipForm)
ipSubmit = tk.Button(ipForm, text='Connect', command=connect)

ipLabel.pack(side=tk.TOP)
ipInput.pack(side=tk.TOP)
ipSubmit.pack(side=tk.TOP)

ipForm.pack(side=tk.TOP)

win.mainloop()
