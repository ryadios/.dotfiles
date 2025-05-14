#!/usr/bin/python

import json
import logging
import os

LOG_FORMAT = "\033[1;32m%(asctime)s\033[0m [\033[1;34m%(levelname)s]\033[0m - %(message)s"
logging.basicConfig(level=logging.INFO,
                    format=LOG_FORMAT,
                    datefmt="%Y-%m-%d %H:%M:%S")
logger = logging.getLogger()

source = "stow.json"


def ensuredir(dir):
    if not os.path.exists(dir):
        os.system("mkdir -p " + dir)


def stow(local, target):
    return os.system("ln -s {0} {1}".format(local, target))


def expand_path(path):
    return os.popen("echo " + path).read().rstrip()


def stow_directories(directories):
    for target in directories:
        target = expand_path(target)
        name = os.path.basename(target)
        src = os.path.abspath(name)

        # Skip if target already exists (dir, symlink, or file)
        if os.path.exists(target) or os.path.islink(target):
            logger.info(f"Skipping existing target: \033[1;33m{target}\033[0m")
            continue

        # Ensure source exists
        if not os.path.exists(src):
            logger.error(f"Source not found: \033[1;31m{src}\033[0m")
            continue

        # Ensure parent directories of target exist
        parent_dir = os.path.dirname(target)
        ensuredir(parent_dir)

        logger.info(
            f"Linking \033[1;36m{target}\033[0m → \033[1;35m{src}\033[0m")
        stow(src, target)


def stow_files(files):
    for name, targets in files.items():
        if len(targets) == 0:
            continue

        for target in targets:
            target = expand_path(target)

            # Determine the target directory and file name
            target_dir, target_file = os.path.split(target)
            src = os.path.abspath(os.path.join(name, target_file))

            # Skip if source file doesn't exist in repo
            if not os.path.exists(src):
                logger.error(f"Source not found: \033[1;31m{src}\033[0m")
                continue

            # Skip if symlink or file already exists
            if os.path.exists(target) or os.path.islink(target):
                logger.info(
                    f"Skipping existing target: \033[1;33m{target}\033[0m")
                continue

            ensuredir(target_dir)

            logger.info(
                f"Linking \033[1;36m{target}\033[0m → \033[1;35m{src}\033[0m")
            stow(src, target)


with open(source, "r") as sourcefile:
    sourcestr = sourcefile.read()
    sourcejson = json.loads(sourcestr)
    stow_directories(sourcejson["directories"])
    stow_files(sourcejson["files"])
