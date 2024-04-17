#!/usr/bin/env python3

import os
import sys
import subprocess

def main():
  dir = sys.argv[1]

  for root, _dirs, files in os.walk(dir):
    for file_relative_path in files:
      file_path = os.path.join(root, file_relative_path)
      with open(file_path, "rb") as file:
        data = file.read(4)
        if data == bytes([0x7f, 0x45, 0x4c, 0x46]):
          # TODO: switch to python3-pyelftools
          patchelf_result = subprocess.run(["patchelf", "--print-rpath", file_path], stdin=subprocess.DEVNULL, capture_output=True)
          assert(patchelf_result.returncode == 0)
          runpath_output = patchelf_result.stdout.decode("utf8").removesuffix("\n")
          if runpath_output != "":
            runpath = runpath_output.split(":")
          else:
            runpath = []
          runpath_new = []
          for runpath_entry in runpath:
            if runpath_entry == "$ORIGIN" or runpath_entry.startswith("$ORIGIN/"):
              runpath_new.append(runpath_entry)
            else:
              pass
          if runpath != runpath_new:
            if runpath_new == []:
              patchelf_result = subprocess.run(["patchelf", "--remove-rpath", file_path])
              assert(patchelf_result.returncode == 0)
            else:
              patchelf_result = subprocess.run(["patchelf", "--set-rpath", ":".join(runpath_new), file_path])
              assert(patchelf_result.returncode == 0)

if __name__ == "__main__":
  main()
