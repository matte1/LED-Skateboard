#ifndef SCHEDULER_H
#define SCHEDULER_H

#include "projectconfig.h"
#include "core/systick/systick.h"

#define MAX_TASKS 5

typedef void (*SchedulerFunction)(void *param);

struct task_t {
   void (*funct)(void *);
   void *param;
   uint32_t lastCall;
   uint32_t frequency;
   uint8_t TID;
}

#endif
