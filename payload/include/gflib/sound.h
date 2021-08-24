#ifndef GFLIB_SOUND_H
#define GFLIB_SOUND_H

#include "m4a.h"

bool32 EnableSoundVSync(bool32 enable);
void InitSound(void);
void PauseSoundVSync(void);
void PlaySE(u16 song);
void StopSE(u16 song);
void StopAllSound(void);
bool8 sub_020093AC(void);
void FadeOutSE(u16 song, u16 _speed);
void SetSEVolume(u16 song, u16 volume);
void SetSETempo(u16 song, u16 tempo);
void SetSEPitch(u16 song, s16 pitch);
void SoundVSyncOff(void);
void SoundVSyncOn(void);

#endif //GFLIB_SOUND_H
