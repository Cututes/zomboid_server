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

## 2. Instalar la configuración y el mundo

Clona este repo y copia el contenido a tu carpeta de Zomboid (normalmente en
`%USERPROFILE%\Zomboid\`):

1. Copia la carpeta `Server\` de este repo dentro de `%USERPROFILE%\Zomboid\Server\`
   (los 4 archivos deben quedar en `Zomboid\Server\Cututes.ini`, etc.).
2. Copia la carpeta `Saves\Multiplayer\Cututes\` de este repo dentro de
   `%USERPROFILE%\Zomboid\Saves\Multiplayer\Cututes\`.
3. Abre `Zomboid\Server\Cututes.ini` y cambia la línea `Password=CAMBIA_ESTA_CONTRASENA`
   por la contraseña real del server (pregúntala en el chat del grupo, no está en el repo
   a propósito).

## 3. Hostear

- Desde el juego: botón **Host** → elige el server `Cututes` → asegúrate de que todos los
  mods de la tabla estén marcados como activos antes de darle Start.
- O como server dedicado: `ProjectZomboidServer.bat -servername Cututes` desde la carpeta
  de instalación del juego.

## 4. Notas importantes

- **No subas tu contraseña real al repo.** Si la cambias, avisa al grupo por otro medio.
- El archivo `Zomboid\db\Cututes.db` (cuentas/whitelist/admins) **no está en este repo** a
  propósito, para no exponer IDs de Steam ni contraseñas de otros. Como el server tiene
  `Open=true`, no lo necesitas para poder unirte — cada quien crea su cuenta al conectarse
  la primera vez que hostea.
- Si el mundo avanza (alguien juega y guarda progreso), hay que subir de nuevo la carpeta
  `Saves\Multiplayer\Cututes\` actualizada para que el resto continúe desde ahí. Avisen en
  el grupo antes de hostear para no pisarse el progreso entre varios.
