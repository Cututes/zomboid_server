# Cututes — Server de Project Zomboid

Este repo contiene la configuración del server **y el mundo guardado actual**, para que
cualquiera de nosotros pueda hostear y continuar la misma partida.

## 1. Requisitos

- Project Zomboid (build 42.x).
- Suscribirte en Steam Workshop a **todos** estos mods antes de continuar:

| Mod | Workshop ID | Mod ID |
|---|---|---|
| Authentic Z | 2335368829 | `Authentic Z - Current` |
| Skill Recovery Journal | 2503622437 | `SkillRecoveryJournal` |
| Has Been Read | 2544353492 | `P4HasBeenRead` |
| Wolf Extraction Quest | 2987772693 | `WolfExtractionQuest` |
| O.C.D. Inventory | 3773985930 | `OCDInventory` |
| Common Sense | 3750253491 | `VB_CommonSense` |
| Mod Update and Alert System | 3077900375 | `ChuckleberryFinnAlertSystem` |
| errorMagnifier | 2896041179 | `errorMagnifier` |
| NeatUI_Framework | 3508537032 | `NeatUI_Framework` |
| Carry Visible Items | 3749026793 | `CVI` |
| Project Cook | 3490188370 | `Project_Cook` |
| Project Cook Pixel Icon Pack | 3490188370 | `Project_Cook_Pixel_Icon_Pack` |
| Moodle Descriptions Expanded | 3389003300 | `B42MoodleDescriptionsExpanded` |
| Better Containers | 3586216562 | `EURY_CONTAINERS` |
| Players On Map | 2732804047 | `PlayersOnMap` |
| Share Map Notes [B42][MP] | 3676995511 | `PZShareMapNotes` |

Deja que Steam los descargue por completo antes de hostear.

## 2. Instalar (una sola vez por persona)

La idea es que **cualquiera de los 3** pueda hostear la misma partida sin copiar y pegar
la carpeta del save cada vez. En vez de copiar, se crea un *link* entre tu carpeta de
Zomboid y la carpeta clonada del repo — así el juego escribe directo dentro del repo, y
`git` detecta los cambios solo.

1. Clona el repo donde quieras, por ejemplo `C:\ZomboidCututes`:
   ```
   git clone https://github.com/Cututes/zomboid_server.git C:\ZomboidCututes
   ```
2. Cierra el juego si lo tienes abierto.
3. Corre `C:\ZomboidCututes\scripts\setup-link.bat` (doble clic). Esto:
   - Intenta detectar tu carpeta `Zomboid` automáticamente (`%USERPROFILE%\Zomboid` o
     `<disco>:\Zomboid` en la raíz de cualquier disco). Si tú, como en mi caso, la tienes
     en un lugar distinto (ej. `D:\Zomboid` por un `-cachedir` custom en Steam), el script
     te la pregunta una vez y la recuerda para la próxima corrida (no se sube al repo).
   - Crea un link de carpeta (`Saves\Multiplayer\Cututes`) entre tu Zomboid y el repo
     clonado, para que el mundo se guarde directo ahí.
   - Copia/linkea los 4 archivos de `Server\` a tu carpeta de Zomboid.
   - **No necesita permisos de administrador** (usa un "junction", no un symlink normal).
4. Abre `%USERPROFILE%\Zomboid\Server\Cututes.ini` y pon la contraseña real del server en
   la línea `Password=` (pregúntala en el chat del grupo, no está en el repo a propósito).
5. Suscríbete en Steam Workshop a todos los mods de la tabla de arriba y deja que
   terminen de descargar.

## 3. Cada vez que vayas a hostear

1. **Antes** de abrir el juego, corre `scripts\before-hosting.bat`. Esto trae los cambios
   más recientes que haya subido otra persona (si alguien jugó después de ti, tu mundo
   local se actualiza solo).
2. Abre el juego → **Host** → server `Cututes` → confirma que todos los mods estén
   activos → Start.
3. Juega normal. El juego va guardando directo dentro de la carpeta del repo gracias al
   link, no hace falta hacer nada especial mientras juegas.
4. Cuando termines y cierres el server, corre `scripts\after-hosting.bat`. Esto sube tus
   cambios (nuevo estado del mundo) para que la siguiente persona pueda continuar.

Con esos dos scripts, la cadena funciona así: si tú no puedes hostear hoy, la persona
que sí pueda corre `before-hosting.bat`, juega, y corre `after-hosting.bat` — y si esa
persona tampoco puede otro día, la tercera hace exactamente lo mismo y sigue desde donde
quedó.

## 4. Notas importantes

- **Solo una persona debe hostear a la vez.** Si dos hostean al mismo tiempo sin
  coordinarse, `git push` va a rechazar la subida de quien suba segundo (los archivos del
  mundo son binarios y no se pueden combinar automáticamente). Avisen en el chat del grupo
  quién va a hostear antes de empezar.
- Si `after-hosting.bat` falla al subir (`git push` rechazado), es porque alguien subió
  cambios mientras jugabas. No fuerces la subida — pide ayuda en el grupo para resolverlo
  a mano en vez de sobrescribir el progreso de otra persona.
- **No subas tu contraseña real al repo.** Si la cambias, avisa al grupo por otro medio.
- El archivo `Zomboid\db\Cututes.db` (cuentas/whitelist/admins) **no está en este repo** a
  propósito, para no exponer IDs de Steam ni contraseñas de otros. Como el server tiene
  `Open=true`, no lo necesitas para poder unirte — cada quien crea su cuenta al conectarse
  la primera vez que hostea.
- El repo va a crecer con el tiempo porque los archivos del mapa (`chunkdata`, `apop`,
  etc.) cambian binariamente en cada sesión y `git` no puede comprimir esas diferencias
  como con texto. Es normal, no hay que hacer nada al respecto salvo tenerlo en cuenta.
