from rest_framework.permissions import BasePermission


class IsSuperUser(BasePermission):
    def has_permission(self, request, view):
        return bool(request.user and request.user.is_authenticated)

    def has_object_permission(self, request, view, obj: object):
        return request.user.is_superuser


import json


class IsCompanyAdmin(BasePermission):
    def has_permission(self, request, view):
        return True

    def has_object_permission(self, request, view, obj: object):
        if request.method == "GET":
            return bool(request.user and request.user.is_authenticated)
        return bool(
            request.user and request.user.is_authenticated and request.user.is_admin
        )


class IsPermission(BasePermission):
    def __init__(self, permissions):
        self.permissions = permissions

    def has_object_permission(self, request, view, obj: object):
        if request.method == "GET":
            return bool(request.user and request.user.is_authenticated)
        elif request.method == "DELETE":
            return bool(
                request.user
                and request.user.is_authenticated
                and (
                    request.user.role.permissions.filter(
                        name__in=self.permissions
                    ).exists()
                )
            )
        else:
            return bool(
                request.user
                and request.user.is_authenticated
                and (
                    request.user.role.permissions.filter(
                        name__in=self.permissions
                    ).exists()
                    or obj == request.profile
                )
            )

    def __call__(self):
        return self
