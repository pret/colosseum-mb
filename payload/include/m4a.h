#ifndef GUARD_M4A_H
#define GUARD_M4A_H

#include "gba/gba.h"
#include "gba/m4a_internal.h"

extern struct MusicPlayerInfo gMPlayInfo_BGM;
extern struct MusicPlayerInfo gMPlayInfo_SE1;
extern struct MusicPlayerInfo gMPlayInfo_SE2;
extern struct MusicPlayerInfo gMPlayInfo_SE3;

void m4aSoundVSync(void);
void m4aSoundVSyncOn(void);

void m4aSoundInit(void);
void m4aSoundMain(void);
void m4aSongNumStart(u16);
void m4aSongNumStop(u16 n);
void m4aMPlayAllStop(void);
void m4aMPlayContinue(struct MusicPlayerInfo *mplayInfo);
void m4aMPlayFadeOut(struct MusicPlayerInfo *mplayInfo, u16 speed);
void m4aMPlayImmInit(struct MusicPlayerInfo *mplayInfo);
void m4aMPlayFadeIn(struct MusicPlayerInfo *mplayInfo, u16 speed);
void m4aMPlayImmInit(struct MusicPlayerInfo *mplayInfo);
void m4aMPlayVolumeControl(struct MusicPlayerInfo * mplayInfo, u16 chanMask, u16 volume);
void m4aMPlayTempoControl(struct MusicPlayerInfo * mplayInfo, u16 volume);
void m4aMPlayPitchControl(struct MusicPlayerInfo * mplayInfo, u16 chanMask, s16 pitch);

#endif //GUARD_M4A_H
