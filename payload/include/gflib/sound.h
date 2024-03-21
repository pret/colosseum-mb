#ifndef GFLIB_SOUND_H
#define GFLIB_SOUND_H

#include "m4a.h"

bool32 EnableSoundVSync(bool32 enable);
void InitSound(void);
void PauseSoundVSync(void);
void PlaySE(u16 song);
void UNUSED StopSE(u16 song);
void UNUSED StopAllSound(void);
bool8 UNUSED ReturnTrue(void);
void UNUSED FadeOutSE(u16 song, u16 _speed);
void UNUSED SetSEVolume(u16 song, u16 volume);
void UNUSED SetSETempo(u16 song, u16 tempo);
void UNUSED SetSEPitch(u16 song, s16 pitch);
void SoundVSyncOff(void);
void SoundVSyncOn(void);

#endif //GFLIB_SOUND_H
