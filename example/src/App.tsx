import * as React from 'react';
import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { CrispChatSDK, CrispChatUI } from 'react-native-crisp-chat-sdk';

export default function App() {
  const [showChat, setShowChat] = React.useState<boolean>();

  React.useEffect(() => {
    CrispChatSDK.setUserEmail('test@test.com');
  }, []);

  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={() => setShowChat(true)}>
        <Text>Show Chat</Text>
      </TouchableOpacity>
      {showChat && <CrispChatUI style={{ flex: 1, width: '100%' }} />}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
