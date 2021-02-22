/*
 * pthread - minimal implementation of functions used to satisfy a single
 * threaded version.
 */

#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#define MADMACHINE_PTHREAD_DEBUG



// pthread mutex

int pthread_mutex_init(pthread_mutex_t *restrict mutex,
                   const pthread_mutexattr_t *restrict attr)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutex_init(%p,%p)\n", mutex, attr);
        #endif
        memset(mutex, 0, sizeof(pthread_mutex_t));
        return 0;
}

int pthread_mutex_destroy(pthread_mutex_t *mutex)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutex_destroy(%p)\n", mutex);
        #endif
        return 0;
}


int pthread_mutex_lock(pthread_mutex_t *mutex)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutex_lock(%p)\n", mutex);
        #endif
        return 0;
}

int pthread_mutex_trylock(pthread_mutex_t *mutex)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutex_trylock(%p)\n", mutex);
        #endif
        return 0;
}


int pthread_mutex_unlock(pthread_mutex_t *mutex)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutex_unlock(%p)\n", mutex);
        #endif
        return 0;
}


int pthread_mutexattr_init(pthread_mutexattr_t *attr)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutexattr_init(%p)\n", attr);
        #endif
        memset(attr, 0, sizeof(pthread_mutexattr_t));
        return 0;
}


int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int kind)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutexattr_settype(%p, %d)\n", attr, kind);
        #endif
        return 0;
}


int pthread_mutexattr_destroy(pthread_mutexattr_t *attr)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_mutexattr_destroy(%p)\n", attr);
        #endif
        return 0;
}


// pthread condition

int pthread_cond_init(pthread_cond_t *restrict cond,
                  const pthread_condattr_t *restrict cond_attr)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_cond_init(%p,%p)\n", cond, cond_attr);
        #endif
        memset(cond, 0, sizeof(pthread_cond_t));
        return 0;
}


int pthread_cond_destroy(pthread_cond_t *restrict cond)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_cond_destroy(%p)\n", cond);
        #endif
        return 0;
}


int pthread_cond_signal(pthread_cond_t *restrict cond)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_cond_signal(%p)\n", cond);
        #endif
        return 0;
}


int pthread_cond_broadcast(pthread_cond_t *restrict cond)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_cond_broadcast(%p)\n", cond);
        #endif
        return 0;
}


int pthread_cond_wait(pthread_cond_t *restrict cond,
                   pthread_mutex_t *restrict mutex)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_cond_wait(%p, %p)\n", cond, mutex);
        #endif
        return 0;
}




// pthread rwlock


int pthread_rwlock_init(pthread_rwlock_t *restrict rwlock,
                    const pthread_rwlockattr_t *restrict attr)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_rwlock_init(%p, %p)\n", rwlock, attr);
        #endif
        return 0;
}


int pthread_rwlock_destroy(pthread_rwlock_t *rwlock)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_rwlock_destroy(%p)\n", rwlock);
        #endif
        return 0;
}


int pthread_rwlock_tryrdlock(pthread_rwlock_t *rwlock)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_rwlock_tryrdlock(%p)\n", rwlock);
        #endif
        return 0;
}


int pthread_rwlock_rdlock(pthread_rwlock_t *rwlock)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_rwlock_rdlock(%p)\n", rwlock);
        #endif
        return 0;
}


int pthread_rwlock_trywrlock(pthread_rwlock_t *rwlock)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_tryrwlock_wrlock(%p)\n", rwlock);
        #endif
        return 0;
}


int pthread_rwlock_wrlock(pthread_rwlock_t *rwlock)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_rwlock_wrlock(%p)\n", rwlock);
        #endif
        return 0;
}


int pthread_rwlock_unlock(pthread_rwlock_t *rwlock)
{
        #ifdef MADMACHINE_PTHREAD_DEBUG
        printf("pthread_rwlock_unlock(%p)\n", rwlock);
        #endif
        return 0;
}





pthread_t pthread_self(void)
{
    #ifdef MADMACHINE_PTHREAD_DEBUG
    printf("pthread_self()\n");
    #endif
    return 0;
}





// pthread key

// Used as a weak symbol to detect libpthread
int __pthread_key_create (pthread_key_t *key,  void (*destructor) (void *))
{
    #ifdef MADMACHINE_PTHREAD_DEBUG
    printf("pthread_key_create(%p,%p)\n", key, destructor);
    printf("UNIMPLEMENTED: __pthread_key_create()\n");
    #endif
	return 0;
}

int pthread_key_create (pthread_key_t *key, void (*destructor) (void *))
{
    return __pthread_key_create(key, destructor);
}


void *pthread_getspecific (pthread_key_t __key)
{
    #ifdef MADMACHINE_PTHREAD_DEBUG
    printf("UNIMPLEMENTED: pthread_getspecific()\n");
    #endif
	return NULL;
}


// Store POINTER in the thread-specific data slot identified by KEY.
int pthread_setspecific(pthread_key_t __key, const void *__pointer)
{
    #ifdef MADMACHINE_PTHREAD_DEBUG
    printf("UNIMPLEMENTED: pthread_setspecific()\n");
    #endif
	return 0;
}