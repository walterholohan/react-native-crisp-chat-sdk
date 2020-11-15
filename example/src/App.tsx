import * as React from 'react';
import { StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import CrispChat from 'react-native-crisp-chat-sdk';

export default function App() {
  const [showChat, setShowChat] = React.useState<boolean>(false);

  const onShowChat = () => {
    setShowChat(!showChat);
  };

  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={onShowChat}>
        <Text>{showChat ? 'Hide' : 'Show'} Chat</Text>
      </TouchableOpacity>
      {showChat && <CrispChat />}
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
