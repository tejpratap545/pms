from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from .serializers import ProfileInfoSerializer


class ProfileInfoView(generics.RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ProfileInfoSerializer

    def get_object(self):
        return self.request.user.profile
