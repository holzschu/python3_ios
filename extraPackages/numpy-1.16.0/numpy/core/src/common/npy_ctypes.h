#ifndef NPY_CTYPES_H
#define NPY_CTYPES_H

#include <Python.h>

#include "npy_import.h"

/*
 * Check if a python type is a ctypes class.
 *
 * Works like the Py<type>_Check functions, returning true if the argument
 * looks like a ctypes object.
 *
 * This entire function is just a wrapper around the Python function of the
 * same name.
 */
// iOS: move static variables outside of functions
static PyObject *_npy_ctypes_check = NULL;

NPY_INLINE static int
npy_ctypes_check(PyTypeObject *obj)
{
    PyObject *ret_obj;
    int ret;

    npy_cache_import("numpy.core._internal", "npy_ctypes_check", &_npy_ctypes_check);
    if (_npy_ctypes_check == NULL) {
        goto fail;
    }

    ret_obj = PyObject_CallFunctionObjArgs(_npy_ctypes_check, (PyObject *)obj, NULL);
    if (ret_obj == NULL) {
        goto fail;
    }

    ret = PyObject_IsTrue(ret_obj);
    if (ret == -1) {
        goto fail;
    }

    return ret;

fail:
    /* If the above fails, then we should just assume that the type is not from
     * ctypes
     */
    PyErr_Clear();
    return 0;
}

#endif
