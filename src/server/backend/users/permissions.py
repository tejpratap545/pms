from rest_framework.permissions import BasePermission


class IsSuperUser(BasePermission):
    def has_permission(self, request, view):
        return request.user.is_superuser


import json


class IsCompanyAdmin(BasePermission):
    def __init__(self):
        super().__init__()

    def has_permission(self, request, view):
        return bool(request.user and request.user.is_admin)

    def has_object_permission(self, request, view, obj: object):
        if request.method == "GET":
            return bool(request.user and request.user.is_authenticated)
        return bool(
            request.user
            and request.user.is_authenticated
            and request.user.company == obj.company
        )

    def __call__(self):
        return self


class IsProfilePermission(BasePermission):
    def __init__(self):
        super().__init__()

    def has_permission(self, request, view):
        if request.method == "POST":
            return bool(
                request.user
                and request.user.is_authenticated
                and request.user.role.permissions.filter(
                    name="CAN_MANAGE_COMPANY"
                ).exists()
            )
        else:
            return bool(request.user and request.user.is_authenticated)

    def has_object_permission(self, request, view, obj: object):
        if request.method == "GET":
            return bool(request.user and request.user.is_authenticated)
        elif request.method == "DELETE":
            return bool(
                request.user
                and request.user.is_authenticated
                and (
                    request.user.role.permissions.filter(
                        name="CAN_MANAGE_COMPANY"
                    ).exists()
                )
            )
        else:
            return bool(
                request.user
                and request.user.is_authenticated
                and (
                    request.user.role.permissions.filter(
                        name="CAN_MANAGE_COMPANY"
                    ).exists()
                    or obj == request.profile
                )
            )

    def __call__(self):
        return self
