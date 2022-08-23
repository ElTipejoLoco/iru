# ...iru! (PS1) Translation Tools
## Building
- These instructions expect a Windows environment at this time.

### First time prep
1. Inside the "cd" folder is a file called "prepare-clean-bin.bat". Drag and drop your original game bin onto this file. This will unpack the game and prepare the files for modification.

### Creating the patched version
1. Run "build-iru.bat" in the root folder, which will call "0_format.bat," "1_insert.bat," and "2_build.bat." Alternatively, you can run those three individually if you just need that step.
2. The built image will be under "cd\iru.bin" and "cd\iru.cue."

## Modification
- The Spanish build makes a copy of the trans, graphics, exe, and code folder. You can use the "_spanish.bat" files as a reference to copy and make more. It's not the best setup, but this was an earlier project, so we didn't have the best setup :P.
- The "trans" folder has the text script. Anything that starts with // is a comment that will be ignored. Currently the Japanese is commented out with the English below it. **YOU MUST USE SHIFT/JIS CHARACTER ENCODING!!!**
- The "graphics" folder contains several .TIM files that need to be modified, which are a standard PS1 image format.
- The "code" folder has some specific changes due to the added accent characters needed for Spanish.
- The "exe" folder for Spanish is just there so that the English one doesn't get overwritten during build.

The repo might not be the most intuitive since it was designed for personal use, so feel free to ask us questions in discord! - https://discord.gg/bewGNtm

***Not responsible for any instances of Yog-Sothoth appearing near the end of the game as a twist**
